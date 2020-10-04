Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1447282C7F
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 20:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgJDSZh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 14:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726288AbgJDSZh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 14:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601835936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wU6OhJko6VhIO7lVSPg3P81cYiicmmD1jTy02y5YtSU=;
        b=LKid5CDwljYKwYtzKsTNUkTzYsxsMlNlI2SMtcJ+aSycUQVcgmebDhaNAIHX41GtUUYiMy
        gGQNmVhlDIoLpMQ3gTHwmS5Eo+nHqlv/IZRSc78nWRaX5Yn/my5IsI1HHRDRiBIC+r9F36
        7Twohn7tPRDxh6vRUMMz2Bij3XInQFc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-bD5Y3iUePJWM9Q8wL2B9bQ-1; Sun, 04 Oct 2020 14:25:35 -0400
X-MC-Unique: bD5Y3iUePJWM9Q8wL2B9bQ-1
Received: by mail-qv1-f72.google.com with SMTP id k14so4437814qvw.20
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 11:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wU6OhJko6VhIO7lVSPg3P81cYiicmmD1jTy02y5YtSU=;
        b=apxqEjJvM8yUoJ47gDuRxN4SdRgYAPw3MtfwuDwPjWBCBGf1ruJ7idYdznTmfrpaiO
         7OyIztoLSFKwj0xOIPa1gFzB6N3bxhBbZyJmQutIh38scRpfQyGW1RofbtwtmrrBqEB5
         s0zvBD8sGRN69zMoljzzyH6QLmmQwynHzkcjkH4sblrk/l5HcmHIhTuct1FMMzFZki13
         uDA3u9PXZjiW3n21Zra8eX7xl2EvodTG4QxmHxQAaC/3ZyBil8nwetN9ucFNRoN+VOTq
         lwukNHsV7M2WEGzkDswtBAvctCu3uzE+/KE/xAGcs7c1qBJZn8rNsOCTNYsbOg2Lf+gt
         VE3Q==
X-Gm-Message-State: AOAM5334ciSQOle1nzM9rWfL0syknN6kJs8xuG6f9TWNnE3of/t/d1uS
        nW2HfxyRyrkG+zmYm0gW2InwMxR0P4y3hlbJBuTvHbG6IcT2Bovs4dhqaab3KJ9nZRZ/AKQrK8c
        8GMoDYQi9AcKYxaq80RhFiA==
X-Received: by 2002:a05:620a:a52:: with SMTP id j18mr10483352qka.445.1601835934864;
        Sun, 04 Oct 2020 11:25:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcoC9UKCgEDXEt5EzfhF7NcNBdnOuM8EvSugC2qsBV1EiKi8UvArEvWnZX7HBfQdQ7Esb1wQ==
X-Received: by 2002:a05:620a:a52:: with SMTP id j18mr10483335qka.445.1601835934634;
        Sun, 04 Oct 2020 11:25:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k30sm4260566qte.16.2020.10.04.11.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:25:34 -0700 (PDT)
Subject: Re: [PATCH 05/10] fpga: fpga-mgr: machxo2-spi: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-6-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7551aeea-3284-7384-fd43-947d77f29101@redhat.com>
Date:   Sun, 4 Oct 2020 11:25:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-6-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/3/20 10:14 PM, Moritz Fischer wrote:
> Simplify registration using new devm_fpga_mgr_register() API.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/machxo2-spi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

LOTM

Reviewed-by: Tom Rix <trix@redhat.com>


