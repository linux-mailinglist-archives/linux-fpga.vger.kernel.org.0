Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73CA520FA7E
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Jun 2020 19:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390117AbgF3R02 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Jun 2020 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbgF3R01 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Jun 2020 13:26:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5AAC061755;
        Tue, 30 Jun 2020 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=PTxWEstMBHu18X1ijaajKUQM5vwViAK5Whu2SCXSGc4=; b=euiEEt3UPUHl6p/MYdOwi4x4cC
        fspyG1IF6UzfyiKaDMdNu8IZ+fxquRRrWov/i7f5ng3oQCmyFWJCVSsEMzKXjAB4Yjp2MUQ1HDaTX
        BDonvWWco8wiRjJndN+uVBKadEYQ6G+7fuMrGy41v8p1fwNy2z16c0S83u/3si4dwZXRtqIqE4K0r
        B6HhbFEzaOl4WtnvuAfUO/gkLPdNybIr9Qg69AYUJNS/N9RYjZvy4XWaqW5ghlWW0yyHM1Lel8gfS
        FrRyBaV/cknODIY73QpEImRcm3jMbAntXwrhNUTNLlIGYqU6L0bIL9GaJYX2CLSqU+J7TOzgQYBcn
        I3uRxfog==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqK1X-0004Bo-4r; Tue, 30 Jun 2020 17:26:23 +0000
Subject: Re: [RFC 1/1] fpga: dfl: RFC PCI config
To:     trix@redhat.com, hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200630171656.20151-1-trix@redhat.com>
 <20200630171656.20151-2-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <67f7f2b8-3567-aadd-30d6-4cfbc0bc8ce5@infradead.org>
Date:   Tue, 30 Jun 2020 10:26:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630171656.20151-2-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 6/30/20 10:16 AM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Create some top level configs the map to dfl pci cards.
> 
> Autoselect the parts of fpga that are needed to run these cards
> as well as the other subsystem configs to the card's subdevices.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  Documentation/fpga/dfl.rst | 33 +++++++++++++++++++++++++++++++++
>  drivers/fpga/Kconfig       | 28 ++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index d7648d7c7eee..3a872bc8e3d3 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -500,6 +500,39 @@ Developer only needs to provide a sub feature driver with matched feature id.
>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>  
> +Kernel configuration
> +====================
> +
> +While it is possible to manually setup a configuration to match your device,
> +there are some top level configurations that collect configuations for

                                                        configurations

> +some reference pci cards.  Below descibes these configuration as well as

                  PCI               describes

> +what other kernel configs are needed for proper configuration.
> +
> +FPGA_DFL_PAC10
> +Intel Arria 10 GX PCI card, PCI id 0X09C4
> +Depends on
> +  SPI_ALTERA
> +  MFD_INTEL_M10_BMC
> +  MFD_INTEL_M10_BMC_SECURE
> +  SENSORS_INTEL_M10_BMC_HWMON
> +
> +FPGA_DFL_D5005
> +Intel Stratix 10, D5005 PCI card, PCI id 0X0B2B
> +Depends on
> +  SPI_ALTERA
> +  MFD_INTEL_M10_BMC
> +  MFD_INTEL_M10_BMC_SECURE
> +  SENSORS_INTEL_M10_BMC_HWMON
> +  INTEL_S10_PHY
> +
> +FPGA_DFL_N3000
> +Intel Network Accelerator, N3000 PCI card, PCI id 0X0B30
> +Depends on
> +  SPI_ALTERA
> +  MFD_INTEL_M10_BMC
> +  MFD_INTEL_M10_BMC_SECURE
> +  SENSORS_INTEL_M10_BMC_HWMON
> +  INTEL_LL_10G_MAC
>  
>  Open discussion
>  ===============
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 9d53bd9094e2..b657de20bc98 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -138,6 +138,34 @@ config OF_FPGA_REGION
>  	  Support for loading FPGA images by applying a Device Tree
>  	  overlay.
>  
> +config FPGA_DFL_PAC10
> +	tristate "Intel Arria 10 GX PCI card"
> +	select SPI_ALTERA

above kconfig symbol:
	depends on SPI_MASTER

> +	select MFD_INTEL_M10_BMC
> +	select MFD_INTEL_M10_BMC_SECURE
> +	select SENSORS_INTEL_M10_BMC_HWMON

I haven't tested this, but in general it's not safe to select something like
SENSORS* or HWMON* unless you first check that CONFIG_HWMON is enabled.
Otherwise this would usually cause kconfig warning(s).

But don't add things like
	select HWMON
	select SPI
	select SPI_MASTER

because we don't enable subsystems (like HWMON or SPI) just inside one
driver's kconfig entry.
The driver(s) should instead depend on HWMON, SPI, SPI_MASTER etc.

> +	select FPGA_DFL
> +	select FPGA_DFL_FME
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
> +	select FPGA_DFL_PAC10
> +	select INTEL_S10_PHY
> +	select FPGA_DFl_HSSI
> +
> +config FPGA_DFL_N3000
> +	tristate "Intel Network Accelerator, N3000 PCI card"
> +	select FPGA_DFL_PAC10
> +	select INTEL_LL_10G_MAC
> +	select FPGA_DFL_N3000_NIOS
> +
>  config FPGA_DFL
>  	tristate "FPGA Device Feature List (DFL) support"
>  	select FPGA_BRIDGE
> 


-- 
~Randy
