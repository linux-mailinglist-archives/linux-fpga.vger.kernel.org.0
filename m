Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4032F638F
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Jan 2021 15:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbhANO6H (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Jan 2021 09:58:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbhANO6G (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 14 Jan 2021 09:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610636199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbchwcZUiSag5BbIN49pWrX6UaO9j5xtOJpcOaVjMHM=;
        b=ccqXN8xWJnTZBo+/bF0kFNDwwPHcakuR4/zF/KuFdNkIzNn34521p0NfU5hEgAPJrrMhu1
        YsXkz/VKj2I59y4qa8cE2L4yqeDVlwfpC7G30w5T9e9y07atTOtEgnDq1s7zNfhYoBqu57
        HB+BgWYkZNZ+vZz5en1OmjY9wOQVGw4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-Op_2aCAFMzyvKovHaxomwA-1; Thu, 14 Jan 2021 09:56:38 -0500
X-MC-Unique: Op_2aCAFMzyvKovHaxomwA-1
Received: by mail-qk1-f200.google.com with SMTP id x74so4916453qkb.12
        for <linux-fpga@vger.kernel.org>; Thu, 14 Jan 2021 06:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nbchwcZUiSag5BbIN49pWrX6UaO9j5xtOJpcOaVjMHM=;
        b=J2r8jV3JMGBI+cRebL2n5CRM/J2805/TwIV8fNhs9CP86vL7wMp3LiMbcwVCaUK4yQ
         bvmYimMfEON99nS3ibms612N32+B2x+qyrYxHK+G5U4lc/qqYcweYfEweRjYq5/9EzPN
         DJvSzkJZxUYdUj/5pg8QJkTY9H/QJsIzBhZrigQgbQhEqw6jvCZkBiRtvoRBI5Hi8CwO
         ls3GxCDaZUvH9M1CbWHCEUNTyyIDtCN4a146hcVD5XGZMONcRq6tOS/If+eiyMG2ffuE
         AFZKPfbxzRkxyImUu9Fw/BiWOTmq8cPCnlhe/bjAoS8R8+GLkHzuOJJk3Jxj0tjt7l/D
         e2PQ==
X-Gm-Message-State: AOAM533w5lcr1l3/CkPonqcT+BYqROst/awpIPHSlAuoW1IsHiNgVe6M
        rG36VFaegjsmhRRgJUELTkzuxteiyfp4pG8RVvrHGzfhkDnJMNjq8fCVkON7pccZR+9nbI/zh96
        JaLJL5geVJtmAbr/+1rsbQg==
X-Received: by 2002:ae9:f819:: with SMTP id x25mr7421376qkh.429.1610636197639;
        Thu, 14 Jan 2021 06:56:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzC9kWhDdASoCrS9eh0meOVk1AAL4J2tGbvAlfoA4Q2l9zFniGWeZggsOmq/G+R7qqv44Idw==
X-Received: by 2002:ae9:f819:: with SMTP id x25mr7421350qkh.429.1610636197397;
        Thu, 14 Jan 2021 06:56:37 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 6sm3114272qko.3.2021.01.14.06.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 06:56:36 -0800 (PST)
Subject: Re: [PATCH 05/10] docs: fpga: dfl.rst: Fix a couple building issues
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
 <fca8e53692b1e57242e09fc3436cacd1961c8d8b.1610610444.git.mchehab+huawei@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <16cf60e2-74ec-8d51-cb78-0e5e614b5a4c@redhat.com>
Date:   Thu, 14 Jan 2021 06:56:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <fca8e53692b1e57242e09fc3436cacd1961c8d8b.1610610444.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/13/21 11:53 PM, Mauro Carvalho Chehab wrote:
> A title markup length is smaller than required;
> A literal block is not marked as such.
>
> This fixes the warnings below:
>
>     .../Documentation/fpga/dfl.rst:505: WARNING: Title underline too short.
>
>     Location of DFLs on a PCI Device
>     ===========================
>     .../Documentation/fpga/dfl.rst:523: WARNING: Unexpected indentation.
>     .../Documentation/fpga/dfl.rst:523: WARNING: Blank line required after table.
>     .../Documentation/fpga/dfl.rst:524: WARNING: Block quote ends without a blank line; unexpected unindent.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Lukas made an earlier change here

https://lore.kernel.org/linux-fpga/alpine.DEB.2.22.394.2101111016480.2457315@rhweight-WRK1/

Tom


