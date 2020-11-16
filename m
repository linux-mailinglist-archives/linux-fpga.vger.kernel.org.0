Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5DC2B3B7E
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Nov 2020 03:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKPCp7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 21:45:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:49240 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgKPCp7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 15 Nov 2020 21:45:59 -0500
IronPort-SDR: aqiVO5DFMUS+nRjbQ3hrBtm4iiETuPvdM5Xc7uC5+byvCx2dLimPHbgTyCjNhdgd1sBpQYe2at
 cJjkJDwrnm+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="168117394"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="168117394"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 18:45:57 -0800
IronPort-SDR: SdaGANuOcK1wN4nJGO+YR3vn9icdVGYmlxBnOjSB0v1rBF5mpLyhmdhHRqXLeWyK6r84kHNytz
 gCP99sz9LYCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="533262345"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2020 18:45:55 -0800
Date:   Mon, 16 Nov 2020 10:41:47 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, Richard Gong <richard.gong@intel.com>,
        yilun.xu@intel.com
Subject: Re: [PATCHv1 0/4] Extend FPGA manager and region drivers for
Message-ID: <20201116024147.GA8715@yilunxu-OptiPlex-7050>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Nov 12, 2020 at 12:06:39PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> The customer wants to verify that a FPGA bitstream can be started properly
> before saving the bitstream to the QSPI flash memory.
> 
> The customer sends the bitstream via FPGA framework and overlay, the
> firmware will authenticate the bitstream but not program the bitstream to
> device. If the authentication passes, the bitstream will be programmed into
> QSPI flash and will be expected to boot without issues.

So when we have successfully reprogramed region with the
FPGA_MGR_BITSTREM_AUTHENTICATION flag, the bitstream in QSPI flash is
updated but not activated, we need an FPGA reboot to activate it, is it?

Thanks,
Yilun

> 
> Extend FPGA manager and region drivers to support the bitstream
> authentication feature.
> 
> Richard Gong (4):
>   fpga: fpga-mgr: add FPGA_MGR_BITSTREM_AUTHENTICATION flag
>   fpga: of-fpga-region: add authenticate-fpga-config property
>   dt-bindings: fpga: add authenticate-fpga-config property
>   fpga: stratix10-soc: entend driver for bitstream authentication
> 
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
>  drivers/fpga/of-fpga-region.c                          | 3 +++
>  drivers/fpga/stratix10-soc.c                           | 5 ++++-
>  include/linux/fpga/fpga-mgr.h                          | 3 +++
>  4 files changed, 11 insertions(+), 1 deletion(-)
> 
> -- 
> 2.7.4
