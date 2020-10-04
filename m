Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8022A282C84
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 20:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgJDS2F (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 14:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgJDS2F (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 14:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601836084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OZlAhULfVsTLVtcLGXdQHxTvGAoPDqzLOQiT01zOsWk=;
        b=NLVLPTb4jHDp36HgpV19Qt5MXotbcR/4RP/k3GHmOove8CyDMKf+gK8DdU7MpssHV4+3ys
        yL1GAPP8U7a09d/JI2gFeGgFttQVkuhwXaFYJr7NneisiHbQiaP8Dy/HdUT1HyNolECL5u
        OykBFKgpTkgEX9ftk3apnRL3e9Axtus=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-Pm6N4FdeOx6AJR6UutLSug-1; Sun, 04 Oct 2020 14:28:02 -0400
X-MC-Unique: Pm6N4FdeOx6AJR6UutLSug-1
Received: by mail-qt1-f200.google.com with SMTP id u6so4982002qte.8
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 11:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OZlAhULfVsTLVtcLGXdQHxTvGAoPDqzLOQiT01zOsWk=;
        b=c4PDurfZq9Cf8DhVa14nJjv5sAruYK1MZfF5u02XLiCws6Wf6cDMHJCURup1Hl++o2
         qrNqTWPsWP3HSG2WifCUiffHV0AoFdYidEzbMjgtaCU6C8bQOBDUiqFHIg+ARemy2p6y
         1KaGzGdhXeb1x6ibbM4B0AY1jCodiTpBtiBigOiM4CV0HtDLLBdhPU+5NhOmPgr1j33W
         UsS2jp6DuJ/Y6x7iRl6zO107mSqgj017xob2rrSg/i3uhXLjJ7B/1A1TPbprt+g+7ivi
         O0ugMA/dcUr+Qz+bGVfXnNIHw69W+6jGEXWaKNKMH9PDez0+G1sFD5m6hthoWHEENjlK
         Z9yw==
X-Gm-Message-State: AOAM531QoLaXHhPUCeNl8mOV+OYRg9S2XcHnlmxZV7uOf7cya0irLzWj
        nmNzGgvrrLs71JGVxsfs2aNGMwe40q0eA4Xh8o2ZqOhq4l39fhtwvz65Ro/lIwiP04O6WQKs7bl
        kqqoHXW7gZE5jNZdABN3fxg==
X-Received: by 2002:a37:52c1:: with SMTP id g184mr10524738qkb.425.1601836082228;
        Sun, 04 Oct 2020 11:28:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBqfHO+uW3HXxKbyd28iWn0CWtaSnOw8xBD9H9JkH15hCpmEp4kmXoM8GoNPyNaiF2TYHusg==
X-Received: by 2002:a37:52c1:: with SMTP id g184mr10524727qkb.425.1601836082055;
        Sun, 04 Oct 2020 11:28:02 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c1sm6207046qta.86.2020.10.04.11.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:28:01 -0700 (PDT)
Subject: Re: [PATCH 07/10] fpga: fpga-mgr: ts73xx: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-8-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1e6057e5-dd9b-2631-9fb5-ef639519b9b4@redhat.com>
Date:   Sun, 4 Oct 2020 11:27:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-8-mdf@kernel.org>
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
>  drivers/fpga/ts73xx-fpga.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

LOTM

Reviewed-by: Tom Rix <trix@redhat.com>


