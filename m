Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDD12858EF
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Oct 2020 09:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgJGHBF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Oct 2020 03:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGHBF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Oct 2020 03:01:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBDFC0613D2
        for <linux-fpga@vger.kernel.org>; Wed,  7 Oct 2020 00:01:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d81so1147466wmc.1
        for <linux-fpga@vger.kernel.org>; Wed, 07 Oct 2020 00:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2qXBCI2e+b/giZ/fbDsezNblcifBg39XCg3D+hIB9y0=;
        b=yJ1SgiDXaACkYrASBm0+vEF1uFvnw6hj6TdL6wlMfBGxGK60lHWWm2GFVp2ZSKM+SC
         0yNcyz0h0ECRYABG6jT94YTtynx1mx4ePIJdBfjKmq/Uv6Dwf2AERofPueNtJ2qibzO1
         lp2Pg30DAh8epIf3Ob+pwGf2IYlEtMsk+COatDSexN2pzhTjGFRnGAe3uXhoAZP34d6h
         +InIgFRTim4X4TDiOgG/sKxPwghx+n4vKnB4AK2yxmJV5R08MMp3SfWpjFADk5jsn9QF
         qUlyfFdCZGHtQu9pg1rmJziDM5j3Jo2Wua52ihqcApHMlpIkGNPSKD72dw3X4J6ehCYZ
         h2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2qXBCI2e+b/giZ/fbDsezNblcifBg39XCg3D+hIB9y0=;
        b=QbDQbo9b60I2MnjsMUpUECaygR2rtYZgXKDHExhnkYHOq6itYEA5GEK9HMAWwYzeYo
         pU/UWcbtPhWqIMdtURBIBNRSIwK7PnrvD1G7U5DicqvP8U5ZKWeJp8nPMHUGvO1isFgc
         zg59qclEmTioCnyu/F1hHb/dNPpqHp+rKUoO+AyLJA+z2aRxWG3bmPZdKbItnoColyJH
         GWSg56QDZYPnt4bFPKySZJ75v8wMbyS5EECab6UmWZM3ADDXjfscIuMjmAEH3Avlv02C
         eJHOye/J9vFN+KN7mTtfYUk37EWmgUCO+Y2EjRzrOo+li6PZDVNyM3RiiclmxUCutIAk
         RabA==
X-Gm-Message-State: AOAM5306Wv1HdbrkgdOejSuKCt8kyesigP23arOGviHo1qpVoiNj3C34
        TNtKb1eJDZ6Cu6hl0ptWleu06g==
X-Google-Smtp-Source: ABdhPJwWBhy5OqM2JNVdxgjil0NRMXCJsX1dxkkKsUQr/S/ldM3Pg/UfsBvVOzS24rCrOZU8AZrhZQ==
X-Received: by 2002:a1c:3bd4:: with SMTP id i203mr1016900wma.28.1602054061897;
        Wed, 07 Oct 2020 00:01:01 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id y23sm1524512wra.55.2020.10.07.00.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:01:01 -0700 (PDT)
Date:   Wed, 7 Oct 2020 08:00:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v2 1/6] mfd: intel-m10-bmc: support for MAX10 BMC
 Security Engine
Message-ID: <20201007070059.GB1763265@dell>
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201003012412.16831-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 02 Oct 2020, Russ Weight wrote:

> Add macros and definitions required by the MAX10 BMC
> Security Engine driver.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - These functions and macros were previously distributed among
>     the patches that needed them. They are now grouped together
>     in a single patch containing changes to the Intel MAX10 BMC
>     driver.
>   - Added DRBL_ prefix to some definitions
>   - Some address definitions were moved here from the .c files that
>     use them.
> ---
>  include/linux/mfd/intel-m10-bmc.h | 134 ++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index c8ef2f1654a4..880f907302eb 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -13,6 +13,9 @@

>   * m10bmc_raw_read - read m10bmc register per addr
> + * m10bmc_raw_bulk_read - bulk read max10 registers per addr
> + * m10bmc_raw_bulk_write - bulk write max10 registers per addr
> + * m10bmc_raw_update_bits - update max10 register per addr
>   * m10bmc_sys_read - read m10bmc system register per offset
> + * m10bmc_sys_update_bits - update max10 system register per offset
>   */

FWIW, I *hate* abstraction for the sake of abstraction.

Please just use the Regmap API in-place instead.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
