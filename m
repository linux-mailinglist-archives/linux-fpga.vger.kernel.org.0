Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59B4282C71
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 20:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgJDSP6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 14:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbgJDSP5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 14:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601835356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mrSe+vZS53bNuwy2q7zYrWnCsVjNNKWA2YIO62AZBM0=;
        b=B8voeDro2xW2yUh1rBtjOhMbKQhdECSYVmw5AENeBIzzmZjsfvPdJKJmpD0tRCbVqw4Yhz
        RBtErKe2WvnsGoJTiLnvxeWVNCGJcFCuvGw1lAuQYTFBmLlzzAripJ9jTVMmC47qB8nEmo
        cEXnjUZRpasluUASWSWPLfqpW/tKf84=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-rVMoqbUVPrGCLACvcybMdw-1; Sun, 04 Oct 2020 14:15:55 -0400
X-MC-Unique: rVMoqbUVPrGCLACvcybMdw-1
Received: by mail-qk1-f197.google.com with SMTP id f126so296898qke.17
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 11:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mrSe+vZS53bNuwy2q7zYrWnCsVjNNKWA2YIO62AZBM0=;
        b=fS0ZHwEvd7Ty0E5OTeu1ZnJgpLkGvWlDvWJLDAldAUVnec/QHIkP6snhtV5Dwb6Vgg
         0Qz4PBnIDUOi1crwOySscWUKtfWU7JjRKsU0HuoWhFcUEpZTzcp/EGTdJ3sVAtfyVxZT
         p2P0jMvfSl/fxJajNHHwjC0C3EAUWaLjLgj8NelH9u1FeeLunODHvJbzTZsjGEGV+7mz
         u3d+Y8CxUnTHFtrGYgDyGl8phvh2vYiIx9p7P7S4sNEoTyjJ9TbfxmQuCAdbKyexT36u
         ptYF/KnZSnFw1RgLnyZERxP1E8AllefoO/eaA3CGG6GGPtPmbOXD3jMpAqBIF+j+cDeN
         CjaQ==
X-Gm-Message-State: AOAM53316fLAkHoXw6/NZ8CPbs35cVcwa4XJRQXtFc33sCfoW2hB4FVd
        20H62qtL3Y2LgkM8IvGkM3nuM5ot9m9hpngvzdlz4Jhre/2wxFkKIEVjv4evInHBtqlTTn80+YY
        poGboWB5b/2z4pjlwKVRxwg==
X-Received: by 2002:a0c:ac44:: with SMTP id m4mr3186870qvb.50.1601835354673;
        Sun, 04 Oct 2020 11:15:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVUr6M1R/Z6CyNz7FvpTQCknO+UlcbpcaFLyqCNcLT81JWrrTWR76EUxBVmoCbS2nhohE6gA==
X-Received: by 2002:a0c:ac44:: with SMTP id m4mr3186853qvb.50.1601835354525;
        Sun, 04 Oct 2020 11:15:54 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f12sm5760340qti.70.2020.10.04.11.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:15:53 -0700 (PDT)
Subject: Re: [PATCH 02/10] fpga: fpga-mgr: altera-ps-spi: Simplify
 registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-3-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <828731c3-04ca-7c44-7686-863027993d55@redhat.com>
Date:   Sun, 4 Oct 2020 11:15:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-3-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/3/20 10:14 PM, Moritz Fischer wrote:
> Simplify registration by using new devm_fpga_mgr_register() API.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/altera-ps-spi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Looks fine

Reviewed-by: Tom Rix <trix@redhat.com>

