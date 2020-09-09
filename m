Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039B2263842
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Sep 2020 23:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIIVOS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Sep 2020 17:14:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43630 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730030AbgIIVOK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 9 Sep 2020 17:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599686046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flt0vZjtupO4BhZTnrF4cJuXNpxXUArPDdGRHgaQJh8=;
        b=CzuGjdSUJSLmkTU5b/gRMoxmyOFnCuFpYqJbIHu3sH9Lntn3VQSkfASCgyFmxyoDkbn2eF
        DoBiMdZVUAo6nRIW+S+Od8+oVdWDAH21OpqSCfLFblhU2dEgbzHYNn5Gb/tuLKKiwJF7wd
        obpKf/Ga7EB0p+z2WsayNqxuHpVts+Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-i-OUcKpeOBy406feKRMayQ-1; Wed, 09 Sep 2020 17:14:05 -0400
X-MC-Unique: i-OUcKpeOBy406feKRMayQ-1
Received: by mail-qt1-f199.google.com with SMTP id j35so2706706qtk.14
        for <linux-fpga@vger.kernel.org>; Wed, 09 Sep 2020 14:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=flt0vZjtupO4BhZTnrF4cJuXNpxXUArPDdGRHgaQJh8=;
        b=DkjaVkUIscvkkTAUMOGtTPsK/Csr1vZdHLjoi6iLz7kIzYfyWQCucNywhhDoWEkjBu
         0353uNE3g8qQWdJiszghYOL5dSx53z4TWsanU+1zooc2dP9se8w8D6NmCkrnCppX5aPp
         hEgfM/Yx2Ahw5fsFZHZXTuoRh7inSkcfKdg4IdKh/3OG5OIHrNETnxvb4Eit67zrG1a5
         t2W6JU8lQBZcigYS+jSd2Hwj1zl4jC/x24elRXoJT0OHEp87qNqbkMKdPko/SBMIV0jK
         +fm839ff3sfJIuPHI+HYE8sxQ15uZZb1LIq1k1Xsx3VQprMNuLkZM8nz//M/gI5vQrtS
         WDKA==
X-Gm-Message-State: AOAM532BMvuaxmvM4+nYqDWwfI+U47BTg3Jv0JYxMXCFpC7GXh1Jar0n
        tfTDHy52ZRZXpJ+HGlo/3iIKMmpVxpuErmAOPnhwY2Ic8A16ADqvdP8hO/QAlyyx6snRWWzyWNS
        dl1OyPiNCTkBq5OAc5/+zbQ==
X-Received: by 2002:a05:620a:567:: with SMTP id p7mr5307792qkp.164.1599686042139;
        Wed, 09 Sep 2020 14:14:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxelahEbXCJiVWCSYD1eRWMhxmTJwjtxCSAXIXQuZh3Dl5ebQkWRsonB1gBL69zicWzPYE1UA==
X-Received: by 2002:a05:620a:567:: with SMTP id p7mr5307772qkp.164.1599686041865;
        Wed, 09 Sep 2020 14:14:01 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m68sm2009028qkd.105.2020.09.09.14.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 14:14:01 -0700 (PDT)
Subject: Re: [PATCH 0/3] add VFIO mdev support for DFL devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        linux-fpga@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com
References: <1599549212-24253-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <93200a4f-55a3-0798-3ef2-e0467288d5ba@redhat.com>
Date:   Wed, 9 Sep 2020 14:13:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1599549212-24253-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This is a new interface, the documentation needs to go

into greater detail. I am particularly interested in the user workflow.

This seems like it would work only for kernel modules. 

Please describe both in the documentation.

A sample of a user mode driver would be helpful.

Is putting driver_override using sysfs for each device scalable ? would a list sets of {feature id,files}'s the vfio driver respond to better ? 

To be consistent the mdev driver file name should be dfl-vfio-mdev.c

There should be an opt-in flag for drivers being overridden instead of blanket approval of all drivers.

Tom

On 9/8/20 12:13 AM, Xu Yilun wrote:
> These patches depend on the patchset: "Modularization of DFL private
> feature drivers" & "add dfl bus support to MODULE_DEVICE_TABLE()"
>
> https://lore.kernel.org/linux-fpga/1599488581-16386-1-git-send-email-yilun.xu@intel.com/
>
> This patchset provides an VFIO Mdev driver for dfl devices. It makes
> possible for dfl devices be direct accessed from userspace.
>
> Xu Yilun (3):
>   fpga: dfl: add driver_override support
>   fpga: dfl: VFIO mdev support for DFL devices
>   Documentation: fpga: dfl: Add description for VFIO Mdev support
>
>  Documentation/ABI/testing/sysfs-bus-dfl |  20 ++
>  Documentation/fpga/dfl.rst              |  20 ++
>  drivers/fpga/Kconfig                    |   9 +
>  drivers/fpga/Makefile                   |   1 +
>  drivers/fpga/dfl.c                      |  54 ++++-
>  drivers/fpga/vfio-mdev-dfl.c            | 391 ++++++++++++++++++++++++++++++++
>  include/linux/fpga/dfl-bus.h            |   2 +
>  7 files changed, 496 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/fpga/vfio-mdev-dfl.c
>

