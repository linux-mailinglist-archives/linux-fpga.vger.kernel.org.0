Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05D5586D45
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Aug 2022 16:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiHAOtB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Aug 2022 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiHAOtA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 1 Aug 2022 10:49:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429163C8C1
        for <linux-fpga@vger.kernel.org>; Mon,  1 Aug 2022 07:48:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z17so9733006wrq.4
        for <linux-fpga@vger.kernel.org>; Mon, 01 Aug 2022 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=xfavGl+V24YWWqGQjxGg6wv/rP6P6nzIwc+PkoTmd9g=;
        b=F3eYlSWnx1EPxtsoAwL4z8vIGaMaXPZQmlsv1J8GbfsT6UWCz9Oew+Hje6E/Lzoss2
         ws8nNU40Zz5Wmym6A2PnsQw6ehNrahbRDkmp7MVJpFrD9ApgmqiLxJ+SowIit9MNYnsA
         B5Jw2w/EpkX/NGUfxWWy6xXlggBQ3MTDGMxbf/tdMW2Rjwwaw8sCtx7bGOZ6nZ7DgirW
         GP7CGOF9cBJwPO73ZZUiJrlIqmnTE/6OuCnMdHWp5A8Jm1jqKunM6Ks77cshLM2GI5pI
         K1XMxPmTzHGsZauep7t/0otL+TNW6RD2VIgpHKdZvNTbAF/vOTcCqyf5oWBVqEo80Kze
         iHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=xfavGl+V24YWWqGQjxGg6wv/rP6P6nzIwc+PkoTmd9g=;
        b=plMHozxGNqNWUWqUYF30W1Pz8ioI/3MdSfplerqgRJHuQGw41rAz8i6u16Gg+5sQ7c
         sYADE04BqKdtgowpXpGQmOmbLSWQsPOLw4V7yULswguuWr2pgULnYE+uHvdGrH8MRkNb
         0keEIxq530s8GyNXQpWoMkik2gSl+aAPhZ8l9p04XWCf/GoivtypmauublR/ar2ezwfG
         j5+G2pb2ZGCTYcx3KJ+Gy5yz1bgLgC3+Q4E15A2K79euuTouY+M2Mnm8tMcaqLSF7z89
         sD7MHoJuuk/SXFvf8iykCVZYOnEuPQ/CxbTJdY08XXc78eBjqzgySc26tiudAHVz/Kig
         Lrxw==
X-Gm-Message-State: ACgBeo1pZUxL80xxrhUuU0NEDflThCOrsstafiDLOPFrAHrtzkaIGnQ2
        cAlNLH3ccQ1r4kzAAnGaYqnuDg==
X-Google-Smtp-Source: AA6agR748hZ42/2xq5TUD3p3Ru0OZk2V7Ml2AOy7P8m/kQ5I/3Ak6FtVW4Gj5lAp9fNqoHNjIel2zg==
X-Received: by 2002:a5d:4b03:0:b0:220:6b87:8f0f with SMTP id v3-20020a5d4b03000000b002206b878f0fmr1156069wrq.534.1659365337804;
        Mon, 01 Aug 2022 07:48:57 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c1d1500b003a326b84340sm21205193wms.44.2022.08.01.07.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 07:48:57 -0700 (PDT)
Date:   Mon, 1 Aug 2022 15:48:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        russell.h.weight@intel.com, hao.wu@intel.com, trix@redhat.com,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 1/3] mfd: intel-m10-bmc: add m10bmc_sys_update_bits API
Message-ID: <Yufn13ka2TREieeh@google.com>
References: <20220725092836.647028-1-tianfei.zhang@intel.com>
 <20220725092836.647028-2-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725092836.647028-2-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 25 Jul 2022, Tianfei Zhang wrote:

> Adds register access helper functions for M10BMC.
> m10bmc_raw_update_bits() uses to update m10bmc register
> bits per addr.
> m10bmc_sys_update_bits() uses to update m10bmc system
> register bits per offset.
> 
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  include/linux/mfd/intel-m10-bmc.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index f0044b14136e..8e434886a5a1 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -133,6 +133,8 @@ struct intel_m10bmc {
>   *
>   * m10bmc_raw_read - read m10bmc register per addr
>   * m10bmc_sys_read - read m10bmc system register per offset
> + * m10bmc_raw_update_bits - update m10bmc register bits per addr
> + * m10bmc_sys_update_bits - update m10bmc system register bits per offset
>   */
>  static inline int
>  m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> @@ -148,6 +150,20 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>  	return ret;
>  }
>  
> +static inline int
> +m10bmc_raw_update_bits(struct intel_m10bmc *m10bmc, unsigned int addr,
> +		       unsigned int msk, unsigned int val)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(m10bmc->regmap, addr, msk, val);
> +	if (ret)
> +		dev_err(m10bmc->dev, "fail to update reg bits %x: %d\n",
> +			addr, ret);
> +
> +	return ret;
> +}

I really do dislike these 'abstraction for the sake of abstraction'
layers.  Why can't you just use the Regmap API in-place?

>  /*
>   * The base of the system registers could be configured by HW developers, and
>   * in HW SPEC, the base is not added to the addresses of the system registers.
> @@ -158,5 +174,7 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>   */
>  #define m10bmc_sys_read(m10bmc, offset, val) \
>  	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
> +#define m10bmc_sys_update_bits(m10bmc, offset, msk, val) \
> +	m10bmc_raw_update_bits(m10bmc, M10BMC_SYS_BASE + (offset), msk, val)
>  
>  #endif /* __MFD_INTEL_M10_BMC_H */

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
