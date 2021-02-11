Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB1F318535
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 07:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhBKGYi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Feb 2021 01:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhBKGYf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 Feb 2021 01:24:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C040AC06174A;
        Wed, 10 Feb 2021 22:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ORJIOgAJ2KY93EhL4wb57KAdwo8JGQSLCsh+Dw1LNw4=; b=sACq8E3zfoJh83W1vU2gaOvN03
        GxtpKW2k+3HQx0oH68bj4NzzVtu5z24lgIdyhNifxrQjvNwGmlneugtl4OSejpgHLudIrETSYed2N
        6MLi/12H4FsW7Yqvzd3/qcoraSZo/O2Kig+unO2l4JfHb5vOvNbi9KfFvxx0sd5Tw3WbPxXjvgANn
        8615RYdZXdkzV19zDxP9YtC5JQ6yO702350Kbc82PDkR+m+AQhb9QDE1/Af2XoFwCBrclvAOzQsCG
        kdg26FbSXMTTn03AHpH3TAncPpmfgvhmUftjJRSX/BEm+VrdE8Axp/RBhbbzfTMObBRpK7Kfd3zjd
        PgN529zg==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lA5OH-0007vA-S4; Thu, 11 Feb 2021 06:23:50 +0000
Subject: Re: [PATCH v2 3/3] fpga: versal-fpga: Add versal fpga manager driver
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        trix@redhat.com, robh+dt@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
Cc:     git@xilinx.com,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20210211060532.23662-1-nava.manne@xilinx.com>
 <20210211060532.23662-4-nava.manne@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7016de66-f254-2bd6-ce29-3b44133feaa0@infradead.org>
Date:   Wed, 10 Feb 2021 22:23:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211060532.23662-4-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi--

On 2/10/21 10:05 PM, Nava kishore Manne wrote:
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index bf85b9a65ec2..dcd2ed5a7956 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -223,4 +223,12 @@ config FPGA_MGR_ZYNQMP_FPGA
>  	  to configure the programmable logic(PL) through PS
>  	  on ZynqMP SoC.
>  
> +config FPGA_MGR_VERSAL_FPGA
> +        tristate "Xilinx Versal FPGA"
> +        depends on ARCH_ZYNQMP || COMPILE_TEST
> +        help
> +          Select this option to enable FPGA manager driver support for
> +          Xilinx Versal SOC. This driver uses the versal soc firmware

How about consistently capitalizing Versal and SOC (above and below)?

> +          interface to load programmable logic(PL) images
> +          on versal soc.
>  endif # FPGA


thanks.
-- 
~Randy

