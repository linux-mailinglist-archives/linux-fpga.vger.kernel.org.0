Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016F6394893
	for <lists+linux-fpga@lfdr.de>; Sat, 29 May 2021 00:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhE1WP4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 May 2021 18:15:56 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35530 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhE1WPz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 28 May 2021 18:15:55 -0400
Received: by mail-pg1-f176.google.com with SMTP id m190so3577811pga.2;
        Fri, 28 May 2021 15:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JNGpts24AsddyGX9anj8MvAz3SLVAw0SCqNJwlDSL/c=;
        b=sVlSJ+Nn0CELjGBUc66QccYv6/XJLxQi3xCZZJHQF3zTmwc0eHiZldaR/3B2FZqnyQ
         mdA4xbbvLrjcrZ98d/cTRf14KkRY/EnqxidE08a0F3D468fu3Rw7vyn8NPtxYm9Vzvlc
         K/S1BbPhM1R4ry6n6BNCQaGx6zzB5UApC2aZf7z1pWJ53AYiI/qnHl1Im5ORhDzD741e
         to/rR2PikgwtIvnUJVZW82aaajgjOdYnxXKmCec0m0K9zKwOI/2yQxAGutu9vYXwilY1
         9KB0OohrPhNoB9LWkf4nE1bEKlbnNJsf2466Y/6ZRBO3/BA8mm8NrKulwJB5I8hkSYDL
         EgQA==
X-Gm-Message-State: AOAM531mbfLIO6B1oCbTcd1/vnPJjUDUOo34cn5VwWNS/7bHRrEW7v5P
        3CHknYfaP6wmlRoyVUV07JI=
X-Google-Smtp-Source: ABdhPJy6SCN6YWQU2XAi34y1EHfmfd2cb1NOhApHM2dylkDGI7hyzVplHD3S8m33pKULjL0HnHSdZw==
X-Received: by 2002:a63:5a64:: with SMTP id k36mr11130858pgm.365.1622240060434;
        Fri, 28 May 2021 15:14:20 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 191sm5034851pfx.121.2021.05.28.15.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 15:14:19 -0700 (PDT)
Date:   Fri, 28 May 2021 15:14:18 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Navin Sankar Velliangiri <navin@linumiz.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, trix@redhat.com
Subject: Re: [PATCH] fpga: fpga-bridge: removed repeated word
Message-ID: <YLFrOm09nVevsafh@epycbox.lan>
References: <20210528150557.22970-1-navin@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528150557.22970-1-navin@linumiz.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, May 28, 2021 at 08:35:57PM +0530, Navin Sankar Velliangiri wrote:
> Removed repeated word and.
> Reported by checkpatch.
> 
> Signed-off-by: Navin Sankar Velliangiri <navin@linumiz.com>
> ---
>  drivers/fpga/fpga-bridge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index e9266b2a357f..9ada1126faf7 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -228,7 +228,7 @@ EXPORT_SYMBOL_GPL(fpga_bridges_put);
>   * @info: fpga image specific information
>   * @bridge_list: list of FPGA bridges
>   *
> - * Get an exclusive reference to the bridge and and it to the list.
> + * Get an exclusive reference to the bridge and it to the list.
>   *
>   * Return 0 for success, error code from of_fpga_bridge_get() othewise.
>   */
> @@ -258,7 +258,7 @@ EXPORT_SYMBOL_GPL(of_fpga_bridge_get_to_list);
>   * @info: fpga image specific information
>   * @bridge_list: list of FPGA bridges
>   *
> - * Get an exclusive reference to the bridge and and it to the list.
> + * Get an exclusive reference to the bridge and it to the list.
>   *
>   * Return 0 for success, error code from fpga_bridge_get() othewise.
>   */
> -- 
> 2.31.1
> 

Didn't apply on top of Tom's change, so I fixed it up. Queued.

- Moritz
