Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6612BBB7
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Dec 2019 23:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfL0W5a (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Dec 2019 17:57:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33240 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL0W53 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 Dec 2019 17:57:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so15099822pgk.0;
        Fri, 27 Dec 2019 14:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E+kLuWzj80EvnFF/oib9ssslkvZ228O67/W2bXxQ/pc=;
        b=alIASRwC9MAeNWDMqXGCUuildoUx3gjtn4xv1mPE9069xvZVCb7jYDc2Mzk7YX+7ae
         57oXsu8YuVgdU+G9uxwuzcjcGR3q9Nt/gk4ftWUNcajRjz43dDylB0YMhlCwsK4eiU3E
         vWHPLHKma+ofpR9IHrtgk8GPTAFPavKftdZH8RlYGBdLYPaD0GgHXS/K/nu6hc4/v9ps
         ywUgbZobGZJwPCti6Dbw1UkrPGRrAsvqeZnqUBRGVPQ9VxL8nvkNftJQT+IxujaH8seB
         OMHu8seoFCtAevz9ss6G7EFHvdscWSDt6hH89IhYo6vkmNcUhBPFkepVMrOY3AZ2Q9ow
         ni3Q==
X-Gm-Message-State: APjAAAX0/paoeAVqSL/d/eOv9TH5G3Q9odZg9W+ksJHSw8XkoEmBMZnS
        M/dbVHdg6lcvBvrKR0K1gS4=
X-Google-Smtp-Source: APXvYqyzIU5OQ9L7H0wtyUKGd7HslFtp+RRQaTfZ6Ud99txdNoPzFd0/2xHVM2OIIlpp6H79R59Nnw==
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr57958004pgi.159.1577487449227;
        Fri, 27 Dec 2019 14:57:29 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:1443:739:e13:41a5])
        by smtp.gmail.com with ESMTPSA id gc1sm15437871pjb.20.2019.12.27.14.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 14:57:28 -0800 (PST)
Date:   Fri, 27 Dec 2019 14:57:26 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawe.com,
        zhengbin13@huawei.com
Subject: Re: [PATCH] fpga: dfl: fme: remove set but not used variable 'fme'
Message-ID: <20191227225726.GA1643@archbook>
References: <20191226121638.10507-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191226121638.10507-1-yukuai3@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Dec 26, 2019 at 08:16:38PM +0800, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/fpga/dfl-fme-main.c: In function ‘fme_dev_destroy’:
> drivers/fpga/dfl-fme-main.c:678:18: warning: variable ‘fme’ set but not
> used [-Wunused-but-set-variable]
> 
> It is never used and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  drivers/fpga/dfl-fme-main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 7c930e6b314d..1d4690c99268 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -675,10 +675,8 @@ static int fme_dev_init(struct platform_device *pdev)
>  static void fme_dev_destroy(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> -	struct dfl_fme *fme;
>  
>  	mutex_lock(&pdata->lock);
> -	fme = dfl_fpga_pdata_get_private(pdata);
>  	dfl_fpga_pdata_set_private(pdata, NULL);
>  	mutex_unlock(&pdata->lock);
>  }
> -- 
> 2.17.2
> 
Acked-by: Moritz Fischer <mdf@kernel.org>

Thanks,
Moritz
