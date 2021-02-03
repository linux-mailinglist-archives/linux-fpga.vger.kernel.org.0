Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C6930DE17
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Feb 2021 16:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhBCP1Q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Feb 2021 10:27:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232566AbhBCP1N (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 3 Feb 2021 10:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612365947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+OO0QGxJRxpJr8sMMpFu2qoMc9u5TBcGuWeR7oxI9E=;
        b=amO6jA/yNCMWNBbizWrwEnDizgNHeLhNiPfxhAvGERbhGsFPVAyShmSibfB2ElnHOCXp+s
        YVbkb5CNdW0kx8SUiP9lxUooGONbFIVdp3RmHeHmbUwWSZMaay7tE2B+SDrVsXe316DTMy
        A7d78r7aXpj3ih88WtuwRmNAqQaQR5o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-rRQ6S5ucOf-JsGhL71NTRQ-1; Wed, 03 Feb 2021 10:25:45 -0500
X-MC-Unique: rRQ6S5ucOf-JsGhL71NTRQ-1
Received: by mail-qv1-f72.google.com with SMTP id l3so18077565qvz.12
        for <linux-fpga@vger.kernel.org>; Wed, 03 Feb 2021 07:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=b+OO0QGxJRxpJr8sMMpFu2qoMc9u5TBcGuWeR7oxI9E=;
        b=Z7a0ngIL2SfDFGE7anqMTO8wVK06l26YH6CdZ02Eyqt4j6ZORjXTatWPAXM6xspqKR
         o4bQfJpAcECDjI7AiafvQ/MRNdWHXykTFACmwVhLwu+q9z1f6QoRHfN7JeEALI6QMJ4d
         QmwnHSsUjmGS2H/DtCQuacyFBfXMRYrYvrdbiuTQTixJSZiQQ34ZTB9dsCrspoYzpjZ1
         BNhW7V07EHYRF9yti4/rXKyHTP1peMZuJvOE/eX0zxfxZgJluhmrh29xI6nHN0aCDeqD
         2i8djb5kkyKhx1hCJfq3KGJgO+YGBib5TYiIzMX47pSC6U+TJqTXxj0BEOkWfrw8LcVl
         b0IA==
X-Gm-Message-State: AOAM532iCT2dviS5DoqsDnvVWhXeKDx7YoSMx1A2tcc9OFNeyWV/fhSw
        +bBS7pBqC59rfoHoV1ro6BWgEBjIJNyGy5kItsgGsU3sjXWxppVke/vmOD3KPOY91k48c9G0tuu
        E2Ef4lYH5jLiY3BmI256X/Q==
X-Received: by 2002:a05:620a:9c3:: with SMTP id y3mr2924152qky.327.1612365944738;
        Wed, 03 Feb 2021 07:25:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZiAJoPsyG/rAEqjnRYQc8ncW+O35t7mvbUzNxC7oC8T/VxmCoGLid3marDzevZGs1K7oJJQ==
X-Received: by 2002:a05:620a:9c3:: with SMTP id y3mr2924127qky.327.1612365944419;
        Wed, 03 Feb 2021 07:25:44 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q11sm478459qtp.49.2021.02.03.07.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 07:25:43 -0800 (PST)
Subject: Re: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210202230631.198950-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <15f90871-170c-3487-0f99-47cf54163bb7@redhat.com>
Date:   Wed, 3 Feb 2021 07:25:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210202230631.198950-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

..snip..

On 2/2/21 3:06 PM, Russ Weight wrote:
> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
> index 576e94960086..e5020e2b1f3d 100644
> --- a/drivers/fpga/dfl-afu.h
> +++ b/drivers/fpga/dfl-afu.h
> @@ -80,7 +80,7 @@ struct dfl_afu {
>  };
>  
>  /* hold pdata->lock when call __afu_port_enable/disable */
> -void __afu_port_enable(struct platform_device *pdev);
> +int __afu_port_enable(struct platform_device *pdev);
>  int __afu_port_disable(struct platform_device *pdev);
>  

Should the '__' prefix be removed from __afu_port* ?

This would make the function names consistent with the other decls

Tom

>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);

