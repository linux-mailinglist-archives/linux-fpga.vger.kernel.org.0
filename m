Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9832F03F3
	for <lists+linux-fpga@lfdr.de>; Sat,  9 Jan 2021 22:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbhAIV4q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 9 Jan 2021 16:56:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbhAIV4p (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 9 Jan 2021 16:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610229318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBaFxrucQU0ed2RdWwhjfBGkmBAnhqzfC5UaTarB09g=;
        b=FjGDS0BIuW+NGdH7TISad24yYlrY8RwZGyfp/AKpLp5uYMriPvn+AuU9fQd4jTKQi4RNu3
        ry4uY6t0DTRWy9O4EfMzNGiKnPY8blh0gJZjfRnv2VtmDGo6IGUq5QKlBKXqfhoT/KXPHY
        GUK4xPd2ch3mEHtYU1M5xLYcvpw1hBQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-gjx3JotPOXGsw3lhdZG7kA-1; Sat, 09 Jan 2021 16:55:16 -0500
X-MC-Unique: gjx3JotPOXGsw3lhdZG7kA-1
Received: by mail-il1-f200.google.com with SMTP id w3so4595168ilj.17
        for <linux-fpga@vger.kernel.org>; Sat, 09 Jan 2021 13:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rBaFxrucQU0ed2RdWwhjfBGkmBAnhqzfC5UaTarB09g=;
        b=efYkR70OICoRG3tqDjou7OGw2AbTbcEJHPmpNGeZSUa9QL2Q4UF4a7KOAKiaKqUBAq
         7eqwUqC3ixZ/wYo+mEjrgwbZsYvsTVBodz0hqlFimitIPMpiZpugHqeGJmDyd+46lutT
         ueDkdiFb/1c6WEj5ftIh42+7QkxKLIwta4vSrjPDRXWnR20Ue3cY84hmHy4xP235KVMv
         1EJO68HlPdIFV/qMwqG5xgVPTFK5Bg6wQ0/WKyJtSu57wY4PhNCizTffSI8qf4W7iS0J
         8C/r5uAokzqFijTdc++DV49VndqbaXS/4rcO+PxabMNpOq88WUXV5ytkfz4RZO8p8ut8
         1CQw==
X-Gm-Message-State: AOAM530ezyPPEHp9ImXPUdowKCOkLU+037bQyNwxBUEDP8nPOpKdodfv
        uRWAzsKsdtcNovhOmABAzcfI7Mxx1bFhP5YoAfDB/3cwCesDylEDM4lmiiamKYqUVfCbQNh7tCl
        P/V2jLedZSkvi14ZBNscr4w==
X-Received: by 2002:a92:b60a:: with SMTP id s10mr9811677ili.135.1610229316254;
        Sat, 09 Jan 2021 13:55:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+mCVuh53hQm4VKsajFBl21NMXoGLddBOIOgeN0Pseuk9+If0YKzpCWZ9TY+TqhDCUXcX5OA==
X-Received: by 2002:a92:b60a:: with SMTP id s10mr9811669ili.135.1610229316109;
        Sat, 09 Jan 2021 13:55:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h17sm2334071ilr.56.2021.01.09.13.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 13:55:15 -0800 (PST)
Subject: Re: [PATCH] fpga: dfl: fme: Constify static attribute_group structs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210108235414.48017-1-rikard.falkeborn@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a1c87050-0962-5169-8ed4-c1da0098ff34@redhat.com>
Date:   Sat, 9 Jan 2021 13:55:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210108235414.48017-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/8/21 3:54 PM, Rikard Falkeborn wrote:
> The only usage of these is to put their addresses in arrays of pointers
> to const attribute_groups. Make them const to allow the compiler to put
> them in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/fpga/dfl-fme-perf.c | 6 +++---

This looks ok.

There are other 'static struct's in drivers/fpga.

Why is the change limited to this file ?

Tom

>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
> index 531266287eee..4299145ef347 100644
> --- a/drivers/fpga/dfl-fme-perf.c
> +++ b/drivers/fpga/dfl-fme-perf.c
> @@ -192,7 +192,7 @@ static struct attribute *fme_perf_cpumask_attrs[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group fme_perf_cpumask_group = {
> +static const struct attribute_group fme_perf_cpumask_group = {
>  	.attrs = fme_perf_cpumask_attrs,
>  };
>  
> @@ -225,7 +225,7 @@ static struct attribute *fme_perf_format_attrs[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group fme_perf_format_group = {
> +static const struct attribute_group fme_perf_format_group = {
>  	.name = "format",
>  	.attrs = fme_perf_format_attrs,
>  };
> @@ -239,7 +239,7 @@ static struct attribute *fme_perf_events_attrs_empty[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group fme_perf_events_group = {
> +static const struct attribute_group fme_perf_events_group = {
>  	.name = "events",
>  	.attrs = fme_perf_events_attrs_empty,
>  };

