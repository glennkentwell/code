/* libdissent/QByteArrayUtil.cc
   Extra functions to manipulate QByteArrays.

   Author: Shu-Chun Weng <scweng _AT_ cs .DOT. yale *DOT* edu>
 */
/* ====================================================================
 * Dissent: Accountable Group Anonymity
 * Copyright (c) 2010 Yale University.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to
 *
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor,
 *   Boston, MA  02110-1301  USA
 */
#include "QByteArrayUtil.hpp"

#include <QByteArray>

const int QByteArrayUtil::IntegerSize;

static void Int32ToCharArray(quint32 n, char buf[4]){
    // Big Indean
    buf[0] = static_cast<char>(n >> 24 & 0xff);
    buf[1] = static_cast<char>(n >> 16 & 0xff);
    buf[2] = static_cast<char>(n >>  8 & 0xff);
    buf[3] = static_cast<char>(n       & 0xff);
}

static quint32 CharArrayToInt32(const uchar buf[4]){
    // Big Indean
    return buf[0] << 24 | buf[1] << 16 | buf[2] << 8 | buf[3];
}

void QByteArrayUtil::AppendInt(quint32 n, QByteArray* byte_array){
    char buf[IntegerSize];
    Int32ToCharArray(n, buf);
    byte_array->append(buf, IntegerSize);
}

void QByteArrayUtil::PrependInt(quint32 n, QByteArray* byte_array){
    char buf[IntegerSize];
    Int32ToCharArray(n, buf);
    byte_array->prepend(buf, IntegerSize);
}

quint32 QByteArrayUtil::ExtractInt(bool remove, QByteArray* byte_array){
    quint32 n = CharArrayToInt32(reinterpret_cast<const uchar*>(
                byte_array->constData()));
    if(remove)
        byte_array->remove(0, IntegerSize);
    return n;
}
// -*- vim:sw=4:expandtab:cindent:
