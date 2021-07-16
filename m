Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A138C3CB3AA
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Jul 2021 09:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhGPH7W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Jul 2021 03:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbhGPH7R (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 16 Jul 2021 03:59:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37880C061760
        for <linux-fpga@vger.kernel.org>; Fri, 16 Jul 2021 00:56:21 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t5so10978429wrw.12
        for <linux-fpga@vger.kernel.org>; Fri, 16 Jul 2021 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uVR/Jck5v49z+8mpV1Vad40sYJAyKAQCRBapDHKnLq0=;
        b=b173FmM3z/kDXtJkwwpSOdu/0g6cpW7zpOvbLBco/CZeWD6AqepnPtzBG5gG4+c9Qq
         7Qu0jnHuDXsn7aK/PyTqTx+kh/VdIahhyG/JjJtmllOMoH8P3CmptiIdCpyh1r5vELO6
         W+D8QXvBv+5RigjXbKPMIbGHopL7HSUMSVFNb/dE4bevZ9kvndHTUzo05SIkwQyKBOlB
         n8JEzsW5eVebvHJLz9ducXQnO0SMZHZUplG/Q0/+eLlmTl4ZWnWAP+j23t7SEKiS/8o0
         JIFCYcljOpw++5nx/W6NaWMzqTHB+YPkCNttLeOoO+pl9NJ25Vkl0jwzkY0RL/ci12xo
         w4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uVR/Jck5v49z+8mpV1Vad40sYJAyKAQCRBapDHKnLq0=;
        b=R9HBUQ982UA3X1FZLHVBB0me6WBbal/Y2PjYSpbxgV8LNJO6oAmAUavGEOobluBhVA
         E4XPyOlpPc1QXkFYyLsXzcw6VOxMPc/7Xfi9TeGvGJWNK7aq/+FawjjoTr/0SC2CR+oQ
         UUG3OF62PiVa1MFid5paZ/DpwvzMSw12CqtYjN8KM9Lq30mKSmNuoqFoTWdd+5HFz6i0
         vgXVhKG9HF5auLcujKc1JRaQRIKtZ68fMbxTsQjk8pWSQ1B3B8HcuOtM0/Gb6nVwaoPt
         gMmmWYwmuems8ntodmixYlzxxE9W+pccCODYB494onyLg6CUr2lTxj+hKawdQ9qJkeo0
         mavQ==
X-Gm-Message-State: AOAM530yrM+5FtgxTTnqCr4bCEPghES9WlJg60h51YzXfEflFa30qkSp
        2VOMgIVQGy+UaxBvN6itirwuKQ==
X-Google-Smtp-Source: ABdhPJzASykD3R2CXs24CTU0MqQNY5E8qoccE8Z0FhyLoh+efaGHiDUdNcuDK6UwFWGbWEMK/4M3bg==
X-Received: by 2002:a5d:46cc:: with SMTP id g12mr10357001wrs.136.1626422179823;
        Fri, 16 Jul 2021 00:56:19 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id l14sm8810302wrs.22.2021.07.16.00.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 00:56:19 -0700 (PDT)
Date:   Fri, 16 Jul 2021 08:56:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mfd: intel-m10-bmc: add n5010 variant
Message-ID: <YPE7oUflWYJt1IoD@google.com>
References: <20210629121214.988036-1-martin@geanix.com>
 <20210629121214.988036-4-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210629121214.988036-4-martin@geanix.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, 29 Jun 2021, Martin Hundebøll wrote:

> From: Martin Hundebøll <mhu@silicom.dk>
> 
>  The m10-bmc is used on the Silicom N5010 PAC too, so add it to list of
>  m10bmc types.

Please refrain from padding out the commit message in future.

> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> ---
> 
> Changes since v2:
>  * Added Yilun's Reviewed-by
>  * Added Moritz' Acked-by
> 
> Changes since v1:
>  * Patch split out to separate mfd changes
> 
>  drivers/mfd/intel-m10-bmc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
