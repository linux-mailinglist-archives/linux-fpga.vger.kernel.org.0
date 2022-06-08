Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED09954294A
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Jun 2022 10:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiFHIUI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Jun 2022 04:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiFHISF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Jun 2022 04:18:05 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64ED391813
        for <linux-fpga@vger.kernel.org>; Wed,  8 Jun 2022 00:46:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q15so19107752wrc.11
        for <linux-fpga@vger.kernel.org>; Wed, 08 Jun 2022 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XG67bww8RnposxSh7uvw93F6kyW5ZDtDzq1tSglB9nE=;
        b=sZh5IUfQYVHlK8+783p/eoxVSuY7vk2paX24Qr5x7vp0UyPJ/3ACqMk9fcsW+lOgKO
         N3uAukyh3XiTBLUyG2UPira63FkrKMLAxujYmxxUqgY/nSGrYEhLMwq6h34aMTtjnmCv
         tjJIP2tflXfZIJAo/1fVUCBAN/LwJSNwWCarpyhDktG5qMR2Xhcm3YCTOasoH0ECgv/z
         hmaWxjWRG9TKOJsbms00a4r/ChaA/aLhC+EdaGQLmOFt/OndRnYZFhJI1hpWKoWLxWod
         TLxehwkfsiq5oNJ5Os8GI2U4y3pJfZaH9ylVLQNutS0ZoBjb6B8VR2pLoqSNC40WMv2z
         CEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XG67bww8RnposxSh7uvw93F6kyW5ZDtDzq1tSglB9nE=;
        b=3YijjkL1cInQpJ/TzLJzMLTcrkSx4fyRvGM+jZitKSzlycTstgdlHoKtjF7NwSAwjI
         d1CzFwYlPVVTEw5ita//qXLP6SGxHLblDAbInPyavkCACvkrWUS3hYDLDpdI6DJsQjR/
         LFjBVR/r2GMnrVVGv6VuSAq0yu7r3I1APgbC5Tgm09+jsZ5NgHqeDaBi8ABF/FH9AjXX
         2y6k3vNmueBnFjQ6hZOX/fCqM5CSsoTG0Ck9JafgEh3eGjbggcq2k0b8h0YbCzOGvLAc
         UopUzudViYFIMIO3wG6mPDi3t/mo2JVW0X0iq7U78Karj2zBjQXyHaVX4Ys6tpgtD7l2
         C2OA==
X-Gm-Message-State: AOAM530C9Zr4ip+qYJ+HvV90vqkgtWUMZcT6Ozv5z08dZcASlpZ9Nf97
        hLZn+a/pGneXdX/zpkzgZaAKEw==
X-Google-Smtp-Source: ABdhPJwwQKVLr6LrNaVreji1MoQK0L41Yhd/7tWFj4Vwx4iUeklOzgDUzjmUg5xHmS91HlSY0YqPOg==
X-Received: by 2002:a5d:64e3:0:b0:20f:ed9b:7505 with SMTP id g3-20020a5d64e3000000b0020fed9b7505mr31936939wri.408.1654674391390;
        Wed, 08 Jun 2022 00:46:31 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id q66-20020a1c4345000000b0039c463e909asm13535796wma.18.2022.06.08.00.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 00:46:30 -0700 (PDT)
Date:   Wed, 8 Jun 2022 08:46:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v23 1/5] mfd: intel-m10-bmc: Rename n3000bmc-secure driver
Message-ID: <YqBT1O9dxAqeFphE@google.com>
References: <20220606160038.846236-1-russell.h.weight@intel.com>
 <20220606160038.846236-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220606160038.846236-2-russell.h.weight@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 06 Jun 2022, Russ Weight wrote:

> The n3000bmc-secure driver has changed to n3000bmc-sec-update. Update
> the name in the list of the intel-m10-bmc sub-drivers.
> 
> Tested-by: Tianfei Zhang <tianfei.zhang@intel.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v23:
>   - Rebased for 5.19-rc1
> v22:
>   - Added Tested-by tag from Tianfei and Acked-by tag from Yilun.
> v21:
>   - No change
> v20:
>   - No change
> v19:
>   - No change
> v18:
>   - No change
> v17:
>   - This is a new patch to change in the name of the secure update
>     driver.
> ---
>  drivers/mfd/intel-m10-bmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
