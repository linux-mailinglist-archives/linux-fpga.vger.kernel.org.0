Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E3210351
	for <lists+linux-fpga@lfdr.de>; Wed,  1 Jul 2020 07:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgGAFdf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 1 Jul 2020 01:33:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:33732 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgGAFde (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 1 Jul 2020 01:33:34 -0400
IronPort-SDR: UkMtU6NRt+QSjEqSutHnlz2A/hEFIUvDM5W2ijaRP2aAGh7Im5FauqrtsqRtSBWZGkKApLMWbj
 by4FylVjpzeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="146477597"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="146477597"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 22:33:34 -0700
IronPort-SDR: Li5TmMT7kF2lM0eAqalhLBXvz2qWsIrS98ocwsKDKcs/3xrM/jwK83DnivuFvcsh3Uj5JjPu7q
 jL5owpcv51zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="266671399"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2020 22:33:32 -0700
Date:   Wed, 1 Jul 2020 13:29:38 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2] fpga: dfl: RFC PCI config
Message-ID: <20200701052938.GC2186@yilunxu-OptiPlex-7050>
References: <20200630184950.950-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630184950.950-1-trix@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 30, 2020 at 11:49:50AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Create some top level configs the map to dfl pci cards.
> 
> Autoselect the parts of fpga that are needed to run these cards
> as well as the defining the other subsystem dependencies.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  v1 change subsystem selects to depends
> 
>  Documentation/fpga/dfl.rst | 30 ++++++++++++++++++++++++++++++
>  drivers/fpga/Kconfig       | 27 +++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index d7648d7c7eee..c1ae6b539f08 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -500,6 +500,36 @@ Developer only needs to provide a sub feature driver with matched feature id.
>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>  
> +Kernel configuration
> +====================
> +
> +While it is possible to manually setup a configuration to match your device,
> +there are some top level configurations that collect configurations for
> +some reference PCI cards.  Below describes these configuration as well as
> +what other kernel configs are needed for proper configuration.
> +
> +FPGA_DFL_PAC10
> +Intel Arria 10 GX PCI card, PCI id 0X09C4
> +Depends on
> +  SPI_ALTERA
> +  MFD_INTEL_M10_BMC
> +  SENSORS_INTEL_M10_BMC_HWMON
> +
> +FPGA_DFL_D5005
> +Intel Stratix 10, D5005 PCI card, PCI id 0X0B2B
> +Depends on
> +  SPI_ALTERA
> +  MFD_INTEL_M10_BMC
> +  SENSORS_INTEL_M10_BMC_HWMON
> +  INTEL_S10_PHY
> +
> +FPGA_DFL_N3000
> +Intel Network Accelerator, N3000 PCI card, PCI id 0X0B30
> +Depends on
> +  SPI_ALTERA
> +  MFD_INTEL_M10_BMC
> +  SENSORS_INTEL_M10_BMC_HWMON
> +  INTEL_LL_10G_MAC
>  
>  Open discussion
>  ===============
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 9d53bd9094e2..96603b1f6ff5 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -138,6 +138,33 @@ config OF_FPGA_REGION
>  	  Support for loading FPGA images by applying a Device Tree
>  	  overlay.
>  
> +config FPGA_DFL_PAC10
> +	tristate "Intel Arria 10 GX PCI card"
> +	depends on SPI_ALTERA
> +	depends on SENSORS_INTEL_M10_BMC_HWMON
> +	depends on MFD_INTEL_M10_BMC
> +	select FPGA_DFL
> +	select FPGA_DFL_FME

The FPGA_DFL_FME depends on HWMON & PERF_EVENTS, seems we cannot select
it either.

> +	select FPGA_DFL_FME_MGR
> +	select FPGA_DFL_FME_BRIDGE
> +	select FPGA_DFL_FME_REGION
> +	select FPGA_DFL_AFU
> +	select FPGA_DFL_SPI_ALTERA
> +	select FPGA_DFL_PCI
> +	select IFPGA_SEC_MGR
> +
> +config FPGA_DFL_D5005
> +	tristate "Intel Stratix 10, D5005 PCI card"
> +	depends on INTEL_S10_PHY
> +	select FPGA_DFL_PAC10
> +	select FPGA_DFl_HSSI
> +
> +config FPGA_DFL_N3000
> +	tristate "Intel Network Accelerator, N3000 PCI card"
> +	depends on INTEL_LL_10G_MAC
> +	select FPGA_DFL_PAC10
> +	select FPGA_DFL_N3000_NIOS
> +
>  config FPGA_DFL
>  	tristate "FPGA Device Feature List (DFL) support"
>  	select FPGA_BRIDGE
> -- 
> 2.18.1
