Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A71A2F1DCB
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 19:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390305AbhAKSRj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 13:17:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:42548 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389966AbhAKSRj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 13:17:39 -0500
IronPort-SDR: 03tw9AhqhAQ3qXl9/36Ko0lpUhQPH8X4EnJpYND/IQoY6chdDBgclgo5oK2P/uV9xyqxLvETXt
 6/JsYEXk9H3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="178058948"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="178058948"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 10:15:53 -0800
IronPort-SDR: HstuQOBFjueT/RCEbswKktk8XpQMzyI11ZnZQbhOMwKZvBDadOmvJxhX2qHMWh7TvRUAxfQtfn
 VEyNg38hikQw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="399891728"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 10:15:52 -0800
Date:   Mon, 11 Jan 2021 10:16:59 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Moritz Fischer <mdf@kernel.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        Tom Rix <trix@redhat.com>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fpga: dfl-pci: rectify ReST formatting
In-Reply-To: <X/x07V2WqhmkIMcr@archbook>
Message-ID: <alpine.DEB.2.22.394.2101111016480.2457315@rhweight-WRK1>
References: <20210111112113.27242-1-lukas.bulwahn@gmail.com> <X/x07V2WqhmkIMcr@archbook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Mon, 11 Jan 2021, Moritz Fischer wrote:

> Hi Lukas,
>
> On Mon, Jan 11, 2021 at 12:21:13PM +0100, Lukas Bulwahn wrote:
>> Commit fa41d10589be ("fpga: dfl-pci: locate DFLs by PCIe vendor specific
>> capability") provides documentation to the FPGA Device Feature List (DFL)
> Nit: Do you want to make this a Fixes: tag instead?
>> Framework Overview, but introduced new documentation warnings:
>>
>>   ./Documentation/fpga/dfl.rst:
>>     505: WARNING: Title underline too short.
>>     523: WARNING: Unexpected indentation.
>>     523: WARNING: Blank line required after table.
>>     524: WARNING: Block quote ends without a blank line; unexpected unindent.
>>
>> Rectify ReST formatting in ./Documentation/fpga/dfl.rst.
>>
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>> applies cleanly on next-20210111
>>
>> Moritz, Matthew, please ack.
>>
>> Greg, please pick this doc fixup to your fpga -next tree on top of
>> the commit above.
>>
>>  Documentation/fpga/dfl.rst | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>> index ea8cefc18bdb..c41ac76ffaae 100644
>> --- a/Documentation/fpga/dfl.rst
>> +++ b/Documentation/fpga/dfl.rst
>> @@ -502,7 +502,7 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>>  could be a reference.
>>
>>  Location of DFLs on a PCI Device
>> -===========================
>> +================================
>>  The original method for finding a DFL on a PCI device assumed the start of the
>>  first DFL to offset 0 of bar 0.  If the first node of the DFL is an FME,
>>  then further DFLs in the port(s) are specified in FME header registers.
>> @@ -514,6 +514,7 @@ data begins with a 4 byte vendor specific register for the number of DFLs follow
>>  Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Offset/BIR register
>>  indicates the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
>>  zero.
>> +::
>>
>>          +----------------------------+
>>          |31     Number of DFLS      0|
>> --
>> 2.17.1
>>
>
> Thanks for doing this, I was about to send that same patch myself.
>
> - Moritz
>
