Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE072FC194
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Jan 2021 21:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391495AbhASUvV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jan 2021 15:51:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731493AbhASUvA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 19 Jan 2021 15:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611089373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2zkZ60nc0oYz+Jw0v4vLWfZnUOJXoKUEdPKsKZO6hc=;
        b=WgA8jkm8n0LBNEBnhcbGl7rmzfCY/t1GgPYxNikGxYOFF0L2g8ou0wCGNDOKLhtEhPR/Yz
        gft3jf4cToKaDqGAWKBr2UrbGUz7uH01DZBhHxs3djCXWqtMs5QDdlXcl/fa9BiXdvtjk4
        bdTNYnrOFAgSZzblFaM47AOI5c7REvQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-jAsJJrOgPzm5MEYSQah7AQ-1; Tue, 19 Jan 2021 15:49:32 -0500
X-MC-Unique: jAsJJrOgPzm5MEYSQah7AQ-1
Received: by mail-qv1-f71.google.com with SMTP id bp20so20824697qvb.20
        for <linux-fpga@vger.kernel.org>; Tue, 19 Jan 2021 12:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=C2zkZ60nc0oYz+Jw0v4vLWfZnUOJXoKUEdPKsKZO6hc=;
        b=BNgIpFDzKqUolQ9IfFFxFk0ia2rVGIF9XFJ+TzQFih4W/8zg/mOSEiGue3yR8mT7bA
         66jNs1w/9D6IXQvczCbcrhwouZzyV6rjuDJOZWOlEPsLm/VkKCQJcciRjgKE/6uaXe83
         JlufTEL8glkZGK1r4Rfdo6bqzbMb3aBzqwtVJ6p01ZoOLTCI12SXlANvFJMwEPl0UuW6
         4hPjzONaEVQVSQjLKoSKhE3FJmLRwK7bQfPiNyI6917jTbIHn9sPACkrpv/8XYGERZKj
         LvtsxwXXIDq8jmOuTIp2BcpnnYYSvLgsV17VWT7QnDzSFVO3adsWZFrUNcMTxWFbekIz
         NZ/g==
X-Gm-Message-State: AOAM530x3GiZtvSKc+7JG9qLxz6VqDGkk1sj5i0nD73/wzXqbRUiTpKl
        MfzMiT5glpW+6m7GnNnWYNjQBaurDzRqatcnfqbyavJQx4OX93Y9rAdVYZR2HGi+HoD0qcWsGyp
        nwI/gcuaaARk/4DXQgVLyTg==
X-Received: by 2002:ac8:564e:: with SMTP id 14mr6045338qtt.286.1611089371704;
        Tue, 19 Jan 2021 12:49:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7yWKQXou9HBpzcYqZ8RsXxZxxAaFbMWaMbqqtjcbkVrqtnKwMsT4xtWYjmXVeEV11IyPkcQ==
X-Received: by 2002:ac8:564e:: with SMTP id 14mr6045326qtt.286.1611089371485;
        Tue, 19 Jan 2021 12:49:31 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 38sm11016784qtb.67.2021.01.19.12.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 12:49:30 -0800 (PST)
Subject: Re: [PATCH v7 0/6] Intel MAX10 BMC Secure Update Driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210105230855.15019-1-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b13a487f-7437-0278-6a9e-f10a5273065b@redhat.com>
Date:   Tue, 19 Jan 2021 12:49:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105230855.15019-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/5/21 3:08 PM, Russ Weight wrote:

...

>  .../testing/sysfs-driver-intel-m10-bmc-secure |  61 ++
>  MAINTAINERS                                   |   2 +
>  drivers/fpga/Kconfig                          |  11 +
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/intel-m10-bmc-secure.c           | 543 ++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h             |  85 +++

I am having trouble pulling this into my testing branch where i am tracking some other changes to intel-m10-bmc.h

https://lore.kernel.org/lkml/20210114231648.199685-1-russell.h.weight@intel.com/

https://lore.kernel.org/lkml/1609999628-12748-3-git-send-email-yilun.xu@intel.com/

so I am wondering if it makes sense to split the intel-m10-bmc.h change out of this patchset and sent as a single patch to mfd subsystem ?  The change is a bunch of #defines that don't do anything on their own, but will conflict with other similar additions to the h file.

Tom

>  6 files changed, 705 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>

