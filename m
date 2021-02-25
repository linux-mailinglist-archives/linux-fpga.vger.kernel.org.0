Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A6A3253AB
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Feb 2021 17:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhBYQkF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Feb 2021 11:40:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:27169 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhBYQkE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 25 Feb 2021 11:40:04 -0500
IronPort-SDR: 5NpIriPZ2D6i9KmoNexR6gwvTObABRoqtAYyc+xsd3GU0tR6oW4KPUH82TR+UZowT8kCyMY8yL
 NxHLQBvgNGCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="172719718"
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="172719718"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 08:38:14 -0800
IronPort-SDR: FUlDb4p6eOoSGkLqPpBQK6ZJdTEI5LU+Z/Dd9Wj8ctWcDHASZHNMaMVQ75sf6wr0Gfu4e6l1RT
 H2y7+P8F5Hcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="392455525"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2021 08:37:56 -0800
Subject: Re: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
To:     Tom Rix <trix@redhat.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
 <3c6d5adf-c355-f0c8-b843-5bf95f81876e@redhat.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <8fe75a64-0457-16ac-5049-ee8b756ae1ea@linux.intel.com>
Date:   Thu, 25 Feb 2021 10:58:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3c6d5adf-c355-f0c8-b843-5bf95f81876e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The first patch of the version 5 patch set is a fix for the mainline, I 
submitted a separate patch for a fix at the stable.

Regards,
Richard


On 2/25/21 7:28 AM, Tom Rix wrote:
> The first patch is a fix that is targeted for stable.
> 
> Tom
> 
> On 2/25/21 5:07 AM, Gong, Richard wrote:
>> Hi Moritz,
>>
>> Sorry for asking.
>>
>> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
>>
>> Regards,
>> Richard
>>
>> -----Original Message-----
>> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com>
>> Sent: Tuesday, February 9, 2021 4:20 PM
>> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: Gong, Richard <richard.gong@intel.com>
>> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
>>
>> From: Richard Gong <richard.gong@intel.com>
>>
>> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
>>
>> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
>>
>> Bitstream authentication makes sure a signed bitstream has valid signatures.
>>
>> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
>>
>> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature.
>>
>> Richard Gong (7):
>>    firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
>>    firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>>    firmware: stratix10-svc: extend SVC driver to get the firmware version
>>    fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
>>    fpga: of-fpga-region: add authenticate-fpga-config property
>>    dt-bindings: fpga: add authenticate-fpga-config property
>>    fpga: stratix10-soc: extend driver for bitstream authentication
>>
>>   .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
>>   drivers/firmware/stratix10-svc.c                   | 12 ++++-
>>   drivers/fpga/of-fpga-region.c                      | 24 ++++++---
>>   drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
>>   include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
>>   .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
>>   include/linux/fpga/fpga-mgr.h                      |  3 ++
>>   7 files changed, 125 insertions(+), 18 deletions(-)
>>
>> --
>> 2.7.4
>>
> 
