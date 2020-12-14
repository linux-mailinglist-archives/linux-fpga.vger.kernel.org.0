Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744472D9930
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408140AbgLNNng (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 08:43:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:54965 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbgLNNn3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 08:43:29 -0500
IronPort-SDR: kinlOAqVxnyDQjV3DGSODzsSFuQQh+LN3Bkwk895G0lFFaNdY1xzXQoURbeL66CfPvPl9VESo3
 1LCGpy82eI+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="161756078"
X-IronPort-AV: E=Sophos;i="5.78,418,1599548400"; 
   d="scan'208";a="161756078"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 05:41:37 -0800
IronPort-SDR: mvv+aqE5c4q39/kEsfUPaMesogVYOK91scVQY823oXoflySzJ07EcHBIQDjepx+fa54iQLCUgG
 H/6Fp8gzjiOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,418,1599548400"; 
   d="scan'208";a="381659140"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2020 05:41:36 -0800
Subject: Re: [PATCHv2 0/5] Extend Intel service layer, FPGA manager and region
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@intel.com
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <8640e59d-5e38-a32a-2ac6-a178180e816d@linux.intel.com>
Date:   Mon, 14 Dec 2020 08:03:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz, Greg,

Sorry for asking.

Any comment on Intel service layer and FPGA patches submitted on 11/18/20?

Regards,
Richard

On 11/18/20 8:29 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> This is 2nd submission of Intel service layer and FPGA patches.
> 
> The customer wants to verify that a FPGA bitstream can be started properly
> before saving the bitstream to the QSPI flash memory.
> 
> Bitstream authentication makes sure a signed bitstream has valid signatures.
> 
> The customer sends the bitstream via FPGA framework and overlay, the
> firmware will authenticate the bitstream but not program the bitstream to
> device. If the authentication passes, the bitstream will be programmed into
> QSPI flash and will be expected to boot without issues.
> 
> Extend Intel service layer, FPGA manager and region drivers to support the
> bitstream authentication feature.
> 
> Richard Gong (5):
>    firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>    fpga: fpga-mgr: add FPGA_MGR_BITSTREM_AUTHENTICATION flag
>    fpga: of-fpga-region: add authenticate-fpga-config property
>    dt-bindings: fpga: add authenticate-fpga-config property
>    fpga: stratix10-soc: entend driver for bitstream authentication
> 
>   Documentation/devicetree/bindings/fpga/fpga-region.txt |  1 +
>   drivers/fpga/of-fpga-region.c                          |  3 +++
>   drivers/fpga/stratix10-soc.c                           |  3 +++
>   include/linux/firmware/intel/stratix10-svc-client.h    | 11 ++++++++---
>   include/linux/fpga/fpga-mgr.h                          | 13 ++++++++-----
>   5 files changed, 23 insertions(+), 8 deletions(-)
> 
