Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BB19703D
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Aug 2019 05:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfHUDYJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Aug 2019 23:24:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45965 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfHUDYJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 20 Aug 2019 23:24:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id w26so437264pfq.12
        for <linux-fpga@vger.kernel.org>; Tue, 20 Aug 2019 20:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jR0kd8E/wjsd/vD58hqG03ghBqWwRF++q3yiXcP3i4Q=;
        b=aqUL46VSUXudWU0QhN3F7BUlZKyQ3nGWzpsHfah5hu4OI66DMh4dmv6BFTYH4py6MS
         WjFdvM0V97n9rU0rSpxvj1mcDApC2Tr1MlPcZqqtWEQ8Goow2//zK3vBix96twllykqH
         UR8ibEDMBC46crtNB0OVB2cVmeO66XOzUSD+uaa5QkGQb2IaKuloceHmpAcAs9giNpwn
         lqpkA5K7sFXoRAQf9E+gDoFK5rPp/VT+z/IxT2dhYpCLr/vD4fpBZ3T02qZUpyT4InSB
         POlUz6x29PqLX/ApxA/mP+k4SlG5O7AZ3oNID3WADAvQJAqsySacAv2/LRoGCM+8POkx
         LGXQ==
X-Gm-Message-State: APjAAAXt3QCutLjRoWwP/G+qWhDvVtf/1DtpDZRmsPI6vu5caHbClE6C
        A7IKWMqaZ/JBwBGaHPkdhb0xvw==
X-Google-Smtp-Source: APXvYqx02TH2hHNKYt4nqEYXzwAFlFF9WoYyNeM00zGsD5tPI0GF1ZVQQYIRXONJRCZAIgaLN9mj5A==
X-Received: by 2002:a62:e910:: with SMTP id j16mr34286562pfh.123.1566357848815;
        Tue, 20 Aug 2019 20:24:08 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id c13sm22739750pfi.17.2019.08.20.20.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 20:24:07 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:24:06 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v5 1/9] fpga: dfl: make init callback optional
Message-ID: <20190821032406.GA28625@archbox>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
 <1565578204-13969-2-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565578204-13969-2-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

On Mon, Aug 12, 2019 at 10:49:56AM +0800, Wu Hao wrote:
> This patch makes init callback of sub features optional. With
> this change, people don't need to prepare any empty init callback.
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index c0512af..96a2b82 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -271,11 +271,13 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
>  				     struct dfl_feature *feature,
>  				     struct dfl_feature_driver *drv)
>  {
> -	int ret;
> +	int ret = 0;
>  
> -	ret = drv->ops->init(pdev, feature);
> -	if (ret)
> -		return ret;
> +	if (drv->ops->init) {
> +		ret = drv->ops->init(pdev, feature);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	feature->ops = drv->ops;

You could swap it around maybe like so:

int dfl_feature_instance_init() ...
{
	feature->ops = drv->ops;
	if (drv->ops->init)
		return drv->ops->init(pdev, feature);

	return 0;
}

With the caveat that feature->ops gets always set ...

Your call.

Thanks,
Moritz
