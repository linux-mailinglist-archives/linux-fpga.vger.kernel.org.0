Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597472D992A
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 14:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438237AbgLNNpu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 08:45:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439995AbgLNNp1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 08:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607953437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORFLmlQp/tCNolscRyJmkk22u3H2JpKnuQUL30W9bwE=;
        b=KSW2VpG1c9Wz/LXJHfnQq7UcmL1Pc+FSWGSvhIL4nQrjuCYdarDUFZxHK2PGJLSRkav7tv
        UFU6D+zBNHB8Xt074uRScWr9ioovNIMBWQkv/zopfGC8qqTUoterYSH2xfZ/iICOFhd5l8
        9dcFdTmQoyEOarUZbfIK2Rch5xr3BnI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-sy50zs-FNSO5CxpYNIOcVQ-1; Mon, 14 Dec 2020 08:43:56 -0500
X-MC-Unique: sy50zs-FNSO5CxpYNIOcVQ-1
Received: by mail-ot1-f69.google.com with SMTP id 5so7446140oth.4
        for <linux-fpga@vger.kernel.org>; Mon, 14 Dec 2020 05:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ORFLmlQp/tCNolscRyJmkk22u3H2JpKnuQUL30W9bwE=;
        b=JgTluJ/6s82dDmw7MjfG+B6iO3vaKMdwlFPFvLWQXpR94lyielJxcEYOs0JMDkkZUM
         nWusC14Cf6Vk3vDltLJPkHGuq320EJkAqq/O2W1YVDps4CUECLRt+XkdcTQ/s5TaW0C3
         1MenxbFkwy6wk2qUQ1CNzPVUhWAyBSbzlcz+9d4qMABwk6IDI/IWW1Q+de/EktmvSjJM
         w7xgggE6sr6goh4baiBmy2gyQV+X2+2eyI+kdE0ucltgz6i5BNbO8D1hZrCKRWeOKvF1
         k2FhIN2O0ywue6I6/KdzUPxmoPhl74KGsT6IekhH8bQPAEhiGmAyCJIKuWFvmHejZswU
         fRvw==
X-Gm-Message-State: AOAM531+TJmr/04fOOsbYLdNS/bW1S344bFk4Bej6ocL1hovoira0MGU
        bv7w84jI2aV4xAGnfNIzamvaRXSTKeK2rX73C59QYFdwUBJbgrEjGwSaS0Tjni+6Lw5KNptICNA
        bboVS9abLOKr1WY6V4qYZ9A==
X-Received: by 2002:a05:6820:3d8:: with SMTP id s24mr19338578ooj.52.1607953435565;
        Mon, 14 Dec 2020 05:43:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJws4rE8Sq0I4L0qKwagX9d3+zvWND5LcDK+fN4kGOSTYCD424UgKFG4Tdgm9zXVeZWl2QwXOg==
X-Received: by 2002:a05:6820:3d8:: with SMTP id s24mr19338570ooj.52.1607953435389;
        Mon, 14 Dec 2020 05:43:55 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q18sm3853089ood.35.2020.12.14.05.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 05:43:54 -0800 (PST)
Subject: Re: [PATCH 5/8] fpga: dfl: add dfl bus support to
 MODULE_DEVICE_TABLE()
To:     Moritz Fischer <mdf@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        russell.h.weight@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20201210165804.44234-1-mdf@kernel.org>
 <20201210165804.44234-6-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1cda7c87-aff0-d250-274a-15419e3d6939@redhat.com>
Date:   Mon, 14 Dec 2020 05:43:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201210165804.44234-6-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/10/20 8:58 AM, Moritz Fischer wrote:
> From: Xu Yilun <yilun.xu@intel.com>
>
> Device Feature List (DFL) is a linked list of feature headers within the
> device MMIO space. It is used by FPGA to enumerate multiple sub features
> within it. Each feature can be uniquely identified by DFL type and
> feature id, which can be read out from feature headers.
>
> A dfl bus helps DFL framework modularize DFL device drivers for
> different sub features. The dfl bus matches its devices and drivers by
> DFL type and feature id.
>
> This patch adds dfl bus support to MODULE_DEVICE_TABLE() by adding info
> about struct dfl_device_id in devicetable-offsets.c and add a dfl entry
> point in file2alias.c.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
>  scripts/mod/devicetable-offsets.c |  4 ++++
>  scripts/mod/file2alias.c          | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> index 27007c18e754..d8350eea6d1a 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -243,5 +243,9 @@ int main(void)
>  	DEVID(mhi_device_id);
>  	DEVID_FIELD(mhi_device_id, chan);

addition of auxiliary_device_id causes a trivial conflict.

Do you want me resolve and resend the set ?

Tom

>  
> +	DEVID(dfl_device_id);
> +	DEVID_FIELD(dfl_device_id, type);
> +	DEVID_FIELD(dfl_device_id, feature_id);
> +
>  	return 0;
>  }

