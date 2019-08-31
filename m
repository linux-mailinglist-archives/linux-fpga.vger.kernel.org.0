Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F273A4647
	for <lists+linux-fpga@lfdr.de>; Sat, 31 Aug 2019 22:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfHaUzd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 31 Aug 2019 16:55:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35598 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfHaUzd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 31 Aug 2019 16:55:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so5282022pgv.2
        for <linux-fpga@vger.kernel.org>; Sat, 31 Aug 2019 13:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iTsu+i5V+uOh4NWIxid/z2sWPR9ERFgbEIMqA93uhyQ=;
        b=FVOKUfu2oN2aNm8PfZxi46JqwzyPVUdgJaOkMoV9Msnog6A78P0Lvur3eIDKVh1vw3
         Hhzk0mfBiv4L3KdO5SWq+hVVBmP9PAxUg3bGhSkVDWy1vSNC8GxU8cU+651r9iolzjWx
         uDs7JarpDseEXY0sU+Air4erNfSRIwQGRX71InRuM/AdOxGDh90S6jhQpeUIxFBmp9LM
         o8d7DNsRxFOYjWYw1jAqHmhpJd0jPGGsLRFMxfMqPm1OzqGFX5sDbDqCi85vtcY1J1DJ
         n34dyEdd2qyoGAntgPybafsFZrpB9EA04v+qaBYqW+uReoDY3zv5v8FAqd+xDjJurPYA
         ZQPA==
X-Gm-Message-State: APjAAAWhyjuZPf8tUsPjAUw6KJc3DaJUiehXh7PhIpzHc+dOEAj6rJTV
        cIelQmEYmSvasOJhkgSQ3Ev1ug==
X-Google-Smtp-Source: APXvYqygQvjD8Omqym2BxCXukxsDFhPW2JbUzw4XuQF5/NqX/nnnTIVk5zDdG1OX9uUE/0cVoSRW7g==
X-Received: by 2002:a63:755e:: with SMTP id f30mr18700233pgn.246.1567284932358;
        Sat, 31 Aug 2019 13:55:32 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id m9sm11120055pfh.84.2019.08.31.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 13:55:31 -0700 (PDT)
Date:   Sat, 31 Aug 2019 13:55:30 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 14/57] fpga: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190831205530.GA24385@archbox>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-15-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730181557.90391-15-swboyd@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 30, 2019 at 11:15:14AM -0700, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: Moritz Fischer <mdf@kernel.org>
> Cc: linux-fpga@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please apply directly to subsystem trees
> 
>  drivers/fpga/zynq-fpga.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 31ef38e38537..ee7765049607 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -578,10 +578,8 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  	init_completion(&priv->dma_done);
>  
>  	priv->irq = platform_get_irq(pdev, 0);
> -	if (priv->irq < 0) {
> -		dev_err(dev, "No IRQ available\n");
> +	if (priv->irq < 0)
>  		return priv->irq;
> -	}
>  
>  	priv->clk = devm_clk_get(dev, "ref_clk");
>  	if (IS_ERR(priv->clk)) {
> -- 
> Sent by a computer through tubes
> 
Applied to for-next. If all goes well I'll queue it for next PR.
