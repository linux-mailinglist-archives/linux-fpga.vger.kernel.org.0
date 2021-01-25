Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2152030283E
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Jan 2021 17:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbhAYQyI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 11:54:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728723AbhAYQxl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 11:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611593531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi3/EhTCQKXByshBpUGZW/lVojHvkwr5VvXoIisBL5U=;
        b=CRtkvUjFNN+OKZKWXouyLDdjIC6gjdk5JVIhH0IBV/9nFUXmzk2j/1CG69hTNvHSGRm+F0
        LQ8sSLCI0vlgP3Bllp9W8Z9tb4O2jSJLW9vVX4ShcsnOqbDmoWxT8sRjkOcZKfExHPJfnN
        ixOU9Rbes40y3Bt4OyxaFwuNOIDFKfU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-G2k_I-1KPduqm1801F1xtw-1; Mon, 25 Jan 2021 11:52:09 -0500
X-MC-Unique: G2k_I-1KPduqm1801F1xtw-1
Received: by mail-qt1-f198.google.com with SMTP id h16so7394499qta.12
        for <linux-fpga@vger.kernel.org>; Mon, 25 Jan 2021 08:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hi3/EhTCQKXByshBpUGZW/lVojHvkwr5VvXoIisBL5U=;
        b=SMXEEW8hXv3DtvhhgP6399NJFz0BIY8zgP3iLlH6N8bTnTWdrG9ghBuHiWWEl7rTax
         LkSxsmKaYh/W47IBKUTk1XRmRv0j53gtJmQ35NaGjp3Ck5LOAdd2HZMESRCK4TjpVYCV
         Velq/3iZ8dorAt0icsbyeJAmYj3fond3PXnUKWIwl2KjJ0QCB5NtaxXloGBa1aemDBHW
         pDyLKcQWLFRt7H+moYp41QxZbsmg894QhkYvocvwiYmOKreS0s39UVYc/7AxII9GdYHo
         bFIb5ZZyUq3ASfjolWaw5sldmSFiQ8829dFRUiVyPpBmWFDqE4DhKrWF4Oy+LeB7Sk12
         3Mfw==
X-Gm-Message-State: AOAM53151qz8DFcwuVSmNc36/oenFG+GOSF8zsmvF5I2R38tZNl2P7l4
        OXlxWoaw1PuqsxIHB+cQIdsM4dYKhUL7ZMj13xW3cwJGYubAdRyIM4Jl9ynulOpRBP2F9XsDz+w
        b1DX7tkjJ4hI+IqQ8yoOAXA==
X-Received: by 2002:a05:620a:113a:: with SMTP id p26mr1604853qkk.154.1611593529480;
        Mon, 25 Jan 2021 08:52:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwso6b56EVKYW8JYdR6aANSc7NfyrSGapb0gTEHggrInKpFi/oSMMAdoyhVrqVTSFF5DtqH4Q==
X-Received: by 2002:a05:620a:113a:: with SMTP id p26mr1604844qkk.154.1611593529327;
        Mon, 25 Jan 2021 08:52:09 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y67sm12355083qka.68.2021.01.25.08.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:52:08 -0800 (PST)
Subject: Re: [PATCH v9 2/2] Documentation: fpga: dfl: Add description for DFL
 UIO support
To:     Xu Yilun <yilun.xu@intel.com>, gregkh@linuxfoundation.org,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, hao.wu@intel.com
References: <1611564563-9665-1-git-send-email-yilun.xu@intel.com>
 <1611564563-9665-3-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3d7fa820-119c-9887-6bc1-7eba683acec0@redhat.com>
Date:   Mon, 25 Jan 2021 08:52:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611564563-9665-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/25/21 12:49 AM, Xu Yilun wrote:
> This patch adds description for UIO support for dfl devices on DFL
> bus.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2: no doc in v1, add it for v2.
> v3: some documentation fixes.
> v4: documentation change since the driver matching is changed.
> v5: no change.
> v6: improve the title of the userspace driver support section.
>     some word improvement.
> v7: rebased to next-20210119
> v8: some doc fixes.
> v9: some doc change since we switch to the driver in drivers/uio.
> ---
>  Documentation/fpga/dfl.rst | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>


