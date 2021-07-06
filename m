Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2433BDB59
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jul 2021 18:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhGFQbU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jul 2021 12:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42022 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229935AbhGFQbU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jul 2021 12:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625588921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irckbVn6yrKSfa9qUP6LkAQmjlPbZerZu/LlcR/gbWA=;
        b=F3nW489eqWD3v4S1d4bQTNtNZRKuarWQoT6EdduMU5diBnoeNyX/HasLYqOC1Zs/m1++3X
        w5Msq2sTKaQamaLSV0Yp6Vcn88A15fj/55UKGd69OV151GdXUnShzpWYm4IwLm7rmwOV2O
        asozvsLo1OU3+i4Q1z0mwjNdtULzU0M=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-CiOUCqfsO0ywXS_qjk5LSw-1; Tue, 06 Jul 2021 12:28:39 -0400
X-MC-Unique: CiOUCqfsO0ywXS_qjk5LSw-1
Received: by mail-oo1-f69.google.com with SMTP id p8-20020a4aac080000b029024eec9129ddso10101667oon.4
        for <linux-fpga@vger.kernel.org>; Tue, 06 Jul 2021 09:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=irckbVn6yrKSfa9qUP6LkAQmjlPbZerZu/LlcR/gbWA=;
        b=VPnlFaWFdWIZ1muQmjgxHo2sw/m40cg1TVPRyd/W2qusqNJq0sLTFIc+PonEXjOpXC
         yZBLr6BRq+cBfs6+on28OF58yfnIDORhESmG0MGNMpXWhDGXeJj5GeXEdjK1OW2lTD1Q
         +BrASjmZ4PFVxDVpIpZ8CIqWtI0ODSxUAuz1WzRkkgjFleZTM7zAaVcgE6k/Dlo0W1bT
         qK2qNJZbOYdDOL8rR8VKYGyAoGn3UZ8RM96K1QONwXcyMhcJMaYPULzxC0gEiX9ot45z
         tWWfsi3iLPVVLrAV8/wIxAUM3Fn3XIzirWx8MozIluVuhXPwQujrhoLxvhrXJNFM5GK4
         wCGg==
X-Gm-Message-State: AOAM530Wuh7JagrUu5oKpzuK8c7vlL+uARhdmcYCaH5PryCeMquzT71r
        Rqp4ASLIJVXLsA8qzLcyj0xlwaYgCgFMZMbsQISmkYlWc6nOC8Bx7EkR1LEwuhopFSi/3KaWYtZ
        Nx+WwnhxFncppZa0QLj91gw==
X-Received: by 2002:a4a:d781:: with SMTP id c1mr14595928oou.23.1625588918998;
        Tue, 06 Jul 2021 09:28:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbwBNVEJjT5lRnoa5en9DUU3mJO4JDSUNRsL7D1/qT+l2u/1oFJnVkQ0Hb/P/3gd5prA9CZg==
X-Received: by 2002:a4a:d781:: with SMTP id c1mr14595919oou.23.1625588918830;
        Tue, 06 Jul 2021 09:28:38 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p26sm1578132otp.59.2021.07.06.09.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 09:28:38 -0700 (PDT)
Subject: Re: [PATCH 0/4] FPGA Manager address unused variable warnings
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210702035404.397853-1-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d0088161-ec7f-4ff4-d5c1-c0746ca17283@redhat.com>
Date:   Tue, 6 Jul 2021 09:28:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210702035404.397853-1-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/1/21 8:54 PM, Moritz Fischer wrote:
> This patchset addresses a handful of warnings as result of_match_ids
> being not properly wrapped in #ifdef CONFIG_OF.
>
> Moritz Fischer (4):
>    fpga: altera-freeze-bridge: Address warning about unused variable
>    fpga: xiilnx-spi: Address warning about unused variable
>    fpga: xilinx-pr-decoupler: Address warning about unused variable
>    fpga: zynqmp-fpga: Address warning about unused variable
>
>   drivers/fpga/altera-freeze-bridge.c | 2 ++
>   drivers/fpga/xilinx-pr-decoupler.c  | 2 ++
>   drivers/fpga/xilinx-spi.c           | 2 ++
>   drivers/fpga/zynqmp-fpga.c          | 3 ++-
>   4 files changed, 8 insertions(+), 1 deletion(-)

I am not seeing these warnings, but it is still worth doing.

I think a few more files need this change.

altera-ps-spi.c, dfl-n3000-nios.c, altera-hps2fpga.c, stratix10-soc.c, 
socfpga-a10.c, altera-fpga2sdram.c

Not needed for

altera-pr-ip-core-plat.c and ice40-spi.c

These have depends on OF in Kconfig.

Tom

