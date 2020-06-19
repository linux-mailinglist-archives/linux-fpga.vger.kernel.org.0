Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CEF1FFFCF
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Jun 2020 03:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgFSBjg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Jun 2020 21:39:36 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33438 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgFSBjg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 18 Jun 2020 21:39:36 -0400
Received: by mail-il1-f195.google.com with SMTP id z2so7869512ilq.0;
        Thu, 18 Jun 2020 18:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yyFTwLxF2zsVq8m/K3IWyHkNJklS9O5pslkXVu5r9L4=;
        b=NEx7nQKl/SnkBozERRFhbTwY1hD0kDPScxnBIqJChsuIEkxCNTTCpXKJLYWdcBmvjY
         8mf9mZXbDi3EXNwEd8XgM8R9tUwzBPywVJcrPi60bWT6RwKnSIL633wpIhgopWyLnVJe
         dw7086lfBg8fKioImyR1cip+XZeeBSr/RnC+psMRp02x1Zq0q/K+OXthZ1hpBKIAqOW6
         TysDQr84bY2BmccKiVOw/g8cIZDK+/jAg/2swMfuEZeZ0l7eYRYyr8v/wBb5r9oi02NF
         1rAhAzWa4M3jY3XbTNKKb2nV2evhvfmRSEDRH/mrjDeuG5yiuGzw4C5BOj3sYf68J41t
         Mdxg==
X-Gm-Message-State: AOAM531vyeg74wbHGFhS2TlMlem2QijL+Q8tDgDfNadEfGyeO/C9wXgs
        TrKjVS2QeyT+qkDH18ka5nA=
X-Google-Smtp-Source: ABdhPJxNLZOBwtYTAC2KNBmgGhaK5Xm1U92bCJpWvCAJvCL7Z4iFIaEA7eCkbjZwpRwTYyoy81LSxA==
X-Received: by 2002:a92:d691:: with SMTP id p17mr1398378iln.299.1592530775517;
        Thu, 18 Jun 2020 18:39:35 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id v2sm2546259iol.36.2020.06.18.18.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:39:34 -0700 (PDT)
Date:   Thu, 18 Jun 2020 18:39:33 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     trix@redhat.com
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fpga: Fix dead store in fpga-bridge.c
Message-ID: <20200619013933.GE3685@epycbox.lan>
References: <20200608125446.23311-1-trix@redhat.com>
 <20200608125446.23311-3-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608125446.23311-3-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 08, 2020 at 05:54:46AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Using clang's scan-build/view this issue was flagged
> a dead store issue in fpga-bridge.c
> 
> warning: Value stored to 'ret' is never read [deadcode.DeadStores]
>                   ret = id;
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/fpga-bridge.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 4bab9028940a..2deccacc3aa7 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -328,7 +328,7 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
>  				       void *priv)
>  {
>  	struct fpga_bridge *bridge;
> -	int id, ret = 0;
> +	int id, ret;
>  
>  	if (!name || !strlen(name)) {
>  		dev_err(dev, "Attempt to register with no name!\n");
> @@ -340,10 +340,8 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
>  		return NULL;
>  
>  	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0) {
> -		ret = id;
> +	if (id < 0)
>  		goto error_kfree;
> -	}
>  
>  	mutex_init(&bridge->mutex);
>  	INIT_LIST_HEAD(&bridge->node);
> -- 
> 2.18.2
> 
Applied to for-next,

Thanks!
