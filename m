Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308992F0401
	for <lists+linux-fpga@lfdr.de>; Sat,  9 Jan 2021 23:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAIWKZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 9 Jan 2021 17:10:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbhAIWKZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 9 Jan 2021 17:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610230138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qM7Jheprpt1SAQLOKWSi1zo9qIcexhjMy4GDW3sHcww=;
        b=bcsB+8A/cqs1cmD4n0hWRqyZgKEK1UYNWnjxjMZD7bPnFudq5xoF+0gKsTDfOm+JCFNWgr
        C/9Lfpj+KwTYOVrSfR/3Y73PZAeYftK+qz8TMUTL8dvi349KyEJw/hbMp3dM9SrIdq63Hn
        RZ0k+pK1j/GXsMUpytmnbK7ktnmNthM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-Byon0s_gOfm5zRGotmu4LA-1; Sat, 09 Jan 2021 17:08:57 -0500
X-MC-Unique: Byon0s_gOfm5zRGotmu4LA-1
Received: by mail-io1-f71.google.com with SMTP id c7so10368742iob.10
        for <linux-fpga@vger.kernel.org>; Sat, 09 Jan 2021 14:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qM7Jheprpt1SAQLOKWSi1zo9qIcexhjMy4GDW3sHcww=;
        b=AQ1dCa2ui3YSe/ebWVbEvJgC6UegapkhwkYZt6qTmk56F256m53f0KSbwAE0VINVBJ
         zif62ApEZKYICtTRH1VGJ69nGHGFf1dstwfh72ErA7zB5a9GQJrG2zPGv/NXIOpjftfi
         fj/llRvLd/EuAIsDOUf8eLpELXBj/Yj7HqOgVddxnXa+VfR27IEaoVzpy7shWrtP34Bt
         Ex6+Rxke3uUPRUp96i453cnuHe+BGURsgKN6QO4v95QqFB0rhHMZPwtOW+J2eHgbpt4h
         RVb1ZoiqcHWn4iarcjjqmCxZQsgt6Pqw1+4OWr1GH7Z4H2glC83UPMys9kAad9UewL5y
         8XVA==
X-Gm-Message-State: AOAM533RWu+ctITHA9hYsPhcZo0MYzVin7H8Q4lN4jEWSPtz3U0RRhkN
        7bmdZ9RsRjKjKZvdfEQWKpmxnLVa45OnBmZfLLle71CfVn3h1AGTrvNTyMi11IwPPv7cfBB3FA4
        Mc6vFwesH+YW7+uGnKcIhQg==
X-Received: by 2002:a02:a60a:: with SMTP id c10mr8904098jam.123.1610230136399;
        Sat, 09 Jan 2021 14:08:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxm8KJEaPmdFGUKfGLkFLI0QWEZmLtWn7s8d3Am7mLmpNm6S5wLh9ZWZF6kBRaGymEkAcZ0tQ==
X-Received: by 2002:a02:a60a:: with SMTP id c10mr8904092jam.123.1610230136258;
        Sat, 09 Jan 2021 14:08:56 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t17sm7954555ioc.8.2021.01.09.14.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 14:08:55 -0800 (PST)
Subject: Re: [PATCH -next] fpga: Use DEFINE_SPINLOCK() for spinlock
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201228135135.28788-1-zhengyongjun3@huawei.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <58fed6b1-dbab-7696-1086-c8d84cff0379@redhat.com>
Date:   Sat, 9 Jan 2021 14:08:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201228135135.28788-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/28/20 5:51 AM, Zheng Yongjun wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
>  drivers/fpga/fpga-bridge.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 2deccacc3aa7..e9266b2a357f 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -17,7 +17,7 @@ static DEFINE_IDA(fpga_bridge_ida);
>  static struct class *fpga_bridge_class;
>  
>  /* Lock for adding/removing bridges to linked lists*/
> -static spinlock_t bridge_list_lock;
> +static DEFINE_SPINLOCK(bridge_list_lock);
>  
>  /**
>   * fpga_bridge_enable - Enable transactions on the bridge
> @@ -479,8 +479,6 @@ static void fpga_bridge_dev_release(struct device *dev)
>  
>  static int __init fpga_bridge_dev_init(void)
>  {
> -	spin_lock_init(&bridge_list_lock);
> -
>  	fpga_bridge_class = class_create(THIS_MODULE, "fpga_bridge");
>  	if (IS_ERR(fpga_bridge_class))
>  		return PTR_ERR(fpga_bridge_class);

