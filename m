Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463B4471B87
	for <lists+linux-fpga@lfdr.de>; Sun, 12 Dec 2021 17:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhLLQTH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 12 Dec 2021 11:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231550AbhLLQTG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 12 Dec 2021 11:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639325945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cCjOZqs12xhpuMFVCB4bMBXHSeejxEaibApUugkFrU=;
        b=Lz8Cu0/wR2KySHEnREopPZ0mUkYk2tlEykW172pkG1QPpVQRzOPnWZnNhZ7rqmsb8Ife7+
        i4P4YUEMEtS6RPcQv0XTyT2MtTuqMwKnNioQGGR/7vif+UxIah/XtmwaJmV6Evo7V0uRVa
        iHQr8KH3uzm2Kuhe499/qf+29M/D6Ag=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-xWUuRBKePYai-e2o36ZAKA-1; Sun, 12 Dec 2021 11:19:03 -0500
X-MC-Unique: xWUuRBKePYai-e2o36ZAKA-1
Received: by mail-oo1-f69.google.com with SMTP id j11-20020a056820022b00b002c6b134233fso9207457oob.6
        for <linux-fpga@vger.kernel.org>; Sun, 12 Dec 2021 08:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6cCjOZqs12xhpuMFVCB4bMBXHSeejxEaibApUugkFrU=;
        b=O4yTDsHhWD/G90SkhfnXFKjwSudrw2RP156YdZJEFXQoAZBzC4KvsbSEb8EqPKljMO
         uyxYhniuhln8XXKKOIsJ+CbLmDtZEl79CU0oExDZZ6gNiY36+7YxQM4s1cEekiYhlQu1
         0RHtDsf4Fj6ZQTbn8bhjlsY7zKMvW8yIhgLdjqJGnR+yitCyuoed25W80dFbPj+cNBlQ
         3XWPzvJP3nErre3Zcwztt4wE0Aij/OGHCeBfINsbk++naJJZOOuVdXDIBwbC6GSkBALu
         /o9/HRxDfZR2VI+3mtweHGJOr2CBWLJuYFftsoyExpcrIu+605iFproboVr1gQX2TGay
         hDjQ==
X-Gm-Message-State: AOAM530hqammSoT9KL/r6m56FW/SfeR+ZbC7cspp8aLo50BYX0mTVLNI
        ipR8HMxnCv8DowxgwvSWIp2Em/B8NwozTYy04D7SVPIL844gzAnhFIVFNwE+anpH94jS1YbhTJ4
        q32RyhJLt3h1JPAMV2hjfvg==
X-Received: by 2002:a05:6808:1411:: with SMTP id w17mr23185879oiv.10.1639325943157;
        Sun, 12 Dec 2021 08:19:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxX7Uox2evc4myz9kRdrXIaCV/yCvO5RUReZz7+AKUJ1uFZNay6PJDdQIT3IgFssrEYDjCaJQ==
X-Received: by 2002:a05:6808:1411:: with SMTP id w17mr23185866oiv.10.1639325942965;
        Sun, 12 Dec 2021 08:19:02 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w18sm1713186otm.1.2021.12.12.08.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 08:19:02 -0800 (PST)
Subject: Re: [PATCH] fpga: stratix10-soc: fix typo in a comment
To:     Jason Wang <wangborong@cdjrlc.com>, hao.wu@intel.com
Cc:     mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211212031956.46029-1-wangborong@cdjrlc.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c10b3af5-5371-a4c0-bbe6-a29b3c3573ee@redhat.com>
Date:   Sun, 12 Dec 2021 08:19:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211212031956.46029-1-wangborong@cdjrlc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/11/21 7:19 PM, Jason Wang wrote:
> The double `if' in the comment in line 288 is repeated. Remove one
> of them from the comment.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>   drivers/fpga/stratix10-soc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 357cea58ec98..e4f2e83a615b 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -285,7 +285,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>   
>   	/*
>   	 * Loop waiting for buffers to be returned.  When a buffer is returned,
> -	 * reuse it to send more data or free if if all data has been sent.
> +	 * reuse it to send more data or free if all data has been sent.

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

>   	 */
>   	while (count > 0 || s10_free_buffer_count(mgr) != NUM_SVC_BUFS) {
>   		reinit_completion(&priv->status_return_completion);

