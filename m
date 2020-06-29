Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939E720CBBB
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jun 2020 04:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgF2CXT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Jun 2020 22:23:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:41844 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgF2CXS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 28 Jun 2020 22:23:18 -0400
IronPort-SDR: 6tHhmAeo1KG44lZ0CK+3ixCSNaPMXINN1z6TPqIEQWeAq4r5rd1c9w98rjBkvnqG+mJpjUmCwU
 JMWmSOGoFuBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="147444397"
X-IronPort-AV: E=Sophos;i="5.75,293,1589266800"; 
   d="scan'208";a="147444397"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2020 19:23:18 -0700
IronPort-SDR: 9QeAQlFy9BN+1rM6V7gRkUiaq+DRB6cnf5ctktGu4WeGBRbb9mrBS6DO9Y0pV0BLr+Rio/d+tT
 i85FPgocNKWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,293,1589266800"; 
   d="scan'208";a="480625528"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2020 19:23:15 -0700
Date:   Mon, 29 Jun 2020 10:19:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     trix@redhat.com
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com
Subject: Re: [PATCH] fpga: dfl: improve configuration of dfl pci devices
Message-ID: <20200629021924.GB2620@yilunxu-OptiPlex-7050>
References: <20200628151813.7679-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628151813.7679-1-trix@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I think maybe we don't have to select them all. It is now possible for
FPGA DFL boards to work without FME or AFU, providing limited
functionality. It is possible designers trim the bitstream for their
purpose, and also need a smaller driver set.

I think we may add "default FPGA_DFL" for FPGA_DFL_FME,
FPGA_DFL_FME_MGR and others to make life easier.

How do you think?

On Sun, Jun 28, 2020 at 08:18:13AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> To use a dfl pci device, several dfl configs need to be selected.
> This is tedious and error prone.
> 
> So automagically select the needed configs when FPGA_DFL_PCI
> is selected.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/Kconfig | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 7cd5a29fc437..4b9e05af5426 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -138,6 +138,27 @@ config OF_FPGA_REGION
>  	  Support for loading FPGA images by applying a Device Tree
>  	  overlay.
>  
> +config FPGA_DFL_PCI
> +	tristate "FPGA DFL PCIe Device Driver"
> +	depends on PCI
> +	select FPGA_DFL
> +	select FPGA_DFL_FME
> +	select FPGA_DFL_FME_MGR
> +	select FPGA_DFL_FME_BRIDGE
> +	select FPGA_DFL_FME_REGION
> +	select FPGA_DFL_AFU
> +	help
> +	  Select this option to enable PCIe driver for PCIe-based
> +	  Field-Programmable Gate Array (FPGA) solutions which implement
> +	  the Device Feature List (DFL). This driver provides interfaces
> +	  for userspace applications to configure, enumerate, open and access
> +	  FPGA accelerators on the FPGA DFL devices, enables system level
> +	  management functions such as FPGA partial reconfiguration, power
> +	  management and virtualization with DFL framework and DFL feature
> +	  device drivers.
> +
> +	  To compile this as a module, choose M here.
> +
>  config FPGA_DFL
>  	tristate "FPGA Device Feature List (DFL) support"
>  	select FPGA_BRIDGE
> @@ -191,21 +212,6 @@ config FPGA_DFL_AFU
>  	  to the FPGA infrastructure via a Port. There may be more than one
>  	  Port/AFU per DFL based FPGA device.
>  
> -config FPGA_DFL_PCI
> -	tristate "FPGA DFL PCIe Device Driver"
> -	depends on PCI && FPGA_DFL
> -	help
> -	  Select this option to enable PCIe driver for PCIe-based
> -	  Field-Programmable Gate Array (FPGA) solutions which implement
> -	  the Device Feature List (DFL). This driver provides interfaces
> -	  for userspace applications to configure, enumerate, open and access
> -	  FPGA accelerators on the FPGA DFL devices, enables system level
> -	  management functions such as FPGA partial reconfiguration, power
> -	  management and virtualization with DFL framework and DFL feature
> -	  device drivers.
> -
> -	  To compile this as a module, choose M here.
> -
>  config FPGA_MGR_ZYNQMP_FPGA
>  	tristate "Xilinx ZynqMP FPGA"
>  	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
> -- 
> 2.18.1
