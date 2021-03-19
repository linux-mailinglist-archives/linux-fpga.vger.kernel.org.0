Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF4342905
	for <lists+linux-fpga@lfdr.de>; Sat, 20 Mar 2021 00:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhCSXCa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Mar 2021 19:02:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:16264 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhCSXCJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Mar 2021 19:02:09 -0400
IronPort-SDR: oK4UqgX8nC47hxPv7nJh4IIdjma3Hd+NJwS8ZbJyZHvbRtQTMRfRGOxHZCDZ9jVQODaGRiSRsp
 X0l0hnB6MtjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="190017060"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="190017060"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 16:02:08 -0700
IronPort-SDR: WbKmoz4sUiiKsZfFCtm4prI2NIZY4twXdNZidjUx4LJOEAF5uEbhqkDf7cqil1QvjdV1BsnhEm
 9UzkuZFfTOdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; 
   d="scan'208";a="451030855"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2021 16:02:07 -0700
Subject: Re: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
To:     "Gong, Richard" <richard.gong@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <21a8817a-e63e-6029-69a6-6bae5398439a@linux.intel.com>
Date:   Fri, 19 Mar 2021 18:22:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

Thanks for approving the 1st patch of my version 5 patchest, which 
submitted on 02/09/21.

Can you help review the remaining 6 patches from the same version 5 
patchset? I need your ACKs to move forward, or please let me know if 
additional work is need.

Many thanks for your time again!

Regards,
Richard


On 2/25/21 7:07 AM, Gong, Richard wrote:
> Hi Moritz,
> 
> Sorry for asking.
> 
> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
> 
> Regards,
> Richard
> 
> -----Original Message-----
> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com>
> Sent: Tuesday, February 9, 2021 4:20 PM
> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Gong, Richard <richard.gong@intel.com>
> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
> 
> From: Richard Gong <richard.gong@intel.com>
> 
> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
> 
> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
> 
> Bitstream authentication makes sure a signed bitstream has valid signatures.
> 
> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
> 
> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature.
> 
> Richard Gong (7):
>    firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
>    firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>    firmware: stratix10-svc: extend SVC driver to get the firmware version
>    fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
>    fpga: of-fpga-region: add authenticate-fpga-config property
>    dt-bindings: fpga: add authenticate-fpga-config property
>    fpga: stratix10-soc: extend driver for bitstream authentication
> 
>   .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
>   drivers/firmware/stratix10-svc.c                   | 12 ++++-
>   drivers/fpga/of-fpga-region.c                      | 24 ++++++---
>   drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
>   include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
>   .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
>   include/linux/fpga/fpga-mgr.h                      |  3 ++
>   7 files changed, 125 insertions(+), 18 deletions(-)
> 
> --
> 2.7.4
> 
