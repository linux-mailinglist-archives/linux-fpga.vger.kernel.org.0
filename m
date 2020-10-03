Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3022820BA
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Oct 2020 05:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgJCDPS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Oct 2020 23:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgJCDPS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Oct 2020 23:15:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5676C0613D0;
        Fri,  2 Oct 2020 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wDKUxlcya9naUV0UUfQqQb+yB0tpX4ZGEqkBZBtNiOM=; b=Rc/5pEYHyYsfQRSxE1J+0ThmAh
        voTB+SlPTbiwjVg4cgfEEAH52oKElXMj0xgph1dWt/JxxTX5yqbaf3d+nocox2YStHLDJf2fn7uVW
        pefAXSKTXQJnPANSMIRjcOfljk5veun8RS1IA+mtoqTFhzdk1Q2xWLXMFhf9qaAngqy73fk/Rteru
        U4CHEYRKTr5CKmIi8GM/TlNnruogGE3HxamOaDtSIT2GLY+1T/Y5092TENjso2B8d3mny+sNIErsg
        tFKi+QivUS4ACyrOX8gqlEhmbt27W7XlWnM417Byifmy1EAhgqQBG23Rbh9DNQNLEnn5lcXAm0Pw0
        ICpxZw1w==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOY0o-0000O4-KM; Sat, 03 Oct 2020 03:15:06 +0000
Subject: Re: [PATCH v2 2/6] fpga: m10bmc-sec: create max10 bmc security engine
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-3-russell.h.weight@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6854e626-e21b-d3b6-fa31-f150edba6f66@infradead.org>
Date:   Fri, 2 Oct 2020 20:15:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201003012412.16831-3-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 10/2/20 6:24 PM, Russ Weight wrote:
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index c534cc80f398..2380d36b08c7 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -235,4 +235,15 @@ config IFPGA_SEC_MGR
>  	  region and for the BMC. Select this option to enable
>  	  updates for secure FPGA devices.
>  
> +config IFPGA_M10_BMC_SECURE
> +        tristate "Intel MAX10 BMC security engine"
> +	depends on MFD_INTEL_M10_BMC && IFPGA_SEC_MGR
> +        help
> +          Secure update support for the Intel MAX10 board management
> +	  controller.
> +
> +	  This is a subdriver of the Intel MAX10 board management controller
> +	  (BMC) and provides support for secure updates for the BMC image,
> +	  the FPGA image, the Root Entry Hashes, etc.
> +
>  endif # FPGA

Dagnabit, I need a bot to do this.

Clean up the indentation in the Kconfig file.

From Documentation/process/coding-style.rst, section 10:

Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

checkpatch should have found that issue. Did it not?


thanks.
-- 
~Randy

