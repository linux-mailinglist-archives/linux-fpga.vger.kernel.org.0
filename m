Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0C5282C86
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 20:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgJDS2s (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 14:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgJDS2r (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 14:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601836126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xOxSfxeCI1vhD/dskmKSRI9XvKMJ7mCuzK0/TO95BvA=;
        b=TFQ/YTSGqgv+H33fkaXIYgf+X1+mJ3VOwYIixeCFes1UvCUpdHQfYnqZMeBmBYFe0xvQFm
        yD4TVver2phNDcy1NVNKtMWWHL95tjgmfWzRZJ667tEzz+q3QiVyMz+0ySgZLi5vDhNt1+
        81k4sTibatwA2W4owQS3vYnlpnGaWb8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-ghZgF4cpMR2c_ekIfquHbg-1; Sun, 04 Oct 2020 14:28:45 -0400
X-MC-Unique: ghZgF4cpMR2c_ekIfquHbg-1
Received: by mail-qt1-f200.google.com with SMTP id u6so4982812qte.8
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 11:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xOxSfxeCI1vhD/dskmKSRI9XvKMJ7mCuzK0/TO95BvA=;
        b=rIw/CstJu5X3DvgKum3+cwRmWnBssP93wrWsNgomgJnBKMCGZzksS5uMXzYrPWHejV
         bUxK6eNTg/ZTbKvoMSdxMDf0FcXXEoP780ICH1Ia0en7lM2VLzOnLAUceEiCkKJtAZhf
         h6lDCwbQG/Xq/a//79FonhBgPgpAYfLLASLQUlddOziJ+67FzEEuS9mjjJqgdOZY3ICc
         B0tTtEiNMoNRY2Hsnv3HdJlV3jg25t3kmLQY3e4Nd5y09ms1Rp2IWUiGB+b9fKYvl0C1
         3cd1rQzm75+K5IuVWee1mfENwEJKuj0NvqdMbxuykHyELI7eF87op1OLPNd7z1+QfL0G
         Z7lw==
X-Gm-Message-State: AOAM533LNWqsn1spWP9f4q9PF75jdGozmJsPQEmfcDjChIdqZ9qP2yfb
        LOiUkvbsJOhx8yKpXbphTvzXnw63oXhNe7YFpDeGkR7W3j74d63dVugpOJsIi5/JUcrZcdxRp11
        B+SFGG8X1ma3hf5/+gG9rWQ==
X-Received: by 2002:ac8:66da:: with SMTP id m26mr11188062qtp.111.1601836124802;
        Sun, 04 Oct 2020 11:28:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxCRLUrv/x6qqQxWUHnqymYZ8mtoHMNhTSs+0hGnFHZmrk8KbdFz6OM03cgsqXAfd5hwRCYg==
X-Received: by 2002:ac8:66da:: with SMTP id m26mr11188048qtp.111.1601836124631;
        Sun, 04 Oct 2020 11:28:44 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l11sm5715834qkk.35.2020.10.04.11.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:28:44 -0700 (PDT)
Subject: Re: [PATCH 08/10] fpga: fpga-mgr: xilinx-spi: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-9-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2bb733ed-1a8e-c45a-6729-f910f78ffccf@redhat.com>
Date:   Sun, 4 Oct 2020 11:28:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-9-mdf@kernel.org>
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
>  drivers/fpga/xilinx-spi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

LOTM

Reviewed-by: Tom Rix <trix@redhat.com>


