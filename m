Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A106235F35D
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Apr 2021 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350810AbhDNMTV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Apr 2021 08:19:21 -0400
Received: from elektron.elka.pw.edu.pl ([194.29.160.103]:39776 "EHLO
        elektron.elka.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhDNMTV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 14 Apr 2021 08:19:21 -0400
X-Greylist: delayed 1253 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Apr 2021 08:19:20 EDT
Received: from [172.19.1.1] (095160103141.warszawa.vectranet.pl [95.160.103.141])
        (Authenticated sender: wzabolot@elektron.elka.pw.edu.pl)
        by elektron.elka.pw.edu.pl (Postfix) with ESMTPSA id 7DBCF68005B;
        Wed, 14 Apr 2021 13:58:03 +0200 (CEST)
To:     LKML <linux-kernel@vger.kernel.org>
From:   wzab@ise.pw.edu.pl
Subject: Proposal of improvement for DMA - direct passing of hugepages to the
 SG list
Cc:     linux-fpga@vger.kernel.org
Message-ID: <6c7a1cff-3ad6-0a75-c45b-ce437ea156ef@elektron.elka.pw.edu.pl>
Date:   Wed, 14 Apr 2021 13:58:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

I'm working both on DMA engines implementations in FPGA and their Linux 
drivers.
Now I need to create an engine that takes the hugepages-backed buffer 
allocated
by the user-space application and passes it to the device.
My current solution:

https://forums.xilinx.com/t5/Embedded-Linux/How-to-pass-efficiently-the-hugepages-backed-buffer-to-the-BM/m-p/1229340/highlight/true#M49777
or https://stackoverflow.com/a/67065962/1735409

uses the get_user_pages_fast function, to create the kernel mapping,
and then uses sg_alloc_table_from_pages to build sg_table for it.

I have verified that the created sg_table has one entry for each individual
hugepage (so I can efficiently map it for my SG-capable DMA device).

The disadvantage of that solution is that I need to create and keep a 
huge set
of standard-size pages. Because the "struct page" occupies between 56 and 80
bytes, I get the overhead up to 80/4096 which is approx. 2%.

The open question is if I can free those pages as soon as the sg_table
is created? (As far as I know, the hugepages are locked automatically).
Of course it is unclear what happens if the application crashes and its 
mmaped
hugepage-based buffer gets freed. Will the driver be notified about 
closing the
file so that it can disable DMA before that memory can be taken for other
purposes?

To be sure that it doesn't happen maybe it is good to keep those pages 
locked
in the kernel as well.
The big improvement would be if we could have the get_user_hugepages_fast
function. The user should be allowed to create a smaller number of page 
structs.
The function should check if the requested region really consists of 
hugepages
and return an error if it doesn't.

Another important fact is that we don't need a kernel mapping for those 
pages
at all. So it would be good to have yet another function:
sg_alloc_table_from_user_pages
which should take an additional "flag" argument enabling the user to decide
if the area used consists of normal pages or of hugepages.

The function should return an error in  case if the flag does not match the
properties of the region. Of course the function should also lock the pages,
and sg_free_table should unlock them (protecting against the danger
of application crash, that I described above).

As a temporary workaround, is it possible to "manually" walk the pages
creating the application-delivered buffer, verify that they are hugepages,
lock them and create the sg_table?
What functions/macros should be used for that to ensure that the implemented
solution be portable and keeps working in a reasonable number of future 
versions
of the Linux kernel?

I'll appreciate comments, suggestions and considering of the above proposal.
With best regards,
Wojtek

-- 
Wojciech M Zabolotny, PhD, DSc
Institute of Electronic Systems
Faculty of Electronics and Information Technology
Warsaw University of Technology
