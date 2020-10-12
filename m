Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31E628BE29
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Oct 2020 18:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403844AbgJLQlB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Oct 2020 12:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403821AbgJLQlB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 12 Oct 2020 12:41:01 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F88020757;
        Mon, 12 Oct 2020 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602520860;
        bh=PSchTMYAZGm4XlRhk503Scny9jN8e6gp5pDF0YJQMjA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xBVivPSdx4gG1vfdVp+SCjKOZSg/tYMNlg81eQ7gqgrqE2auz6YeFrZt4T99eyt9N
         TZIYci1UljYO4K9P/4DLq68MphR8VnqYpmeHLJQ+EPIcq3EzCt9KPTBmd9CLCFhiRZ
         U3YMl1FxX7TbSe+R9LMxUw4iOF3NUaTMyQ3uWDVM=
Received: by mail-ed1-f48.google.com with SMTP id l24so17699527edj.8;
        Mon, 12 Oct 2020 09:41:00 -0700 (PDT)
X-Gm-Message-State: AOAM531h6cCm9py4KNzcnnpgLp8Uq5S5jpmDF/vzjDIVFnlW6SnL8qut
        6fyGWpnFQN7lB8J3HjFiU95WB/LpxiZ5mq16xvw=
X-Google-Smtp-Source: ABdhPJwbDxzW+aOToT1vhKutyZ5JIiHEPZCuXxZ7lSkdvp4lGrrSP9KM6nhy4LYqTY2ASPsOgqG7cdwob5MUJdcgf/I=
X-Received: by 2002:a50:d0d0:: with SMTP id g16mr15002684edf.18.1602520858740;
 Mon, 12 Oct 2020 09:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com> <1602313793-21421-7-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1602313793-21421-7-git-send-email-yilun.xu@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 12 Oct 2020 18:40:46 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcLbnvXJLa6G8Rpa8tLv4v22dDVPBDx4DrakPnbGdK4QA@mail.gmail.com>
Message-ID: <CAJKOXPcLbnvXJLa6G8Rpa8tLv4v22dDVPBDx4DrakPnbGdK4QA@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] memory: dfl-emif: add the DFL EMIF private feature driver
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, Russ Weight <russell.h.weight@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, 10 Oct 2020 at 09:15, Xu Yilun <yilun.xu@intel.com> wrote:
>
> This driver is for the EMIF private feature implemented under FPGA
> Device Feature List (DFL) framework. It is used to expose memory
> interface status information as well as memory clearing control.
>
> The purpose of memory clearing block is to zero out all private memory
> when FPGA is to be reprogrammed. This gives users a reliable method to
> prevent potential data leakage.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> v2: Adjust the position of this driver in Kconfig.
>     Improves the name of the Kconfig option.
>     Change the include dfl-bus.h to dfl.h, cause the previous patchset
>      renames the file.
>     Some minor fixes and comment improvement.
> v3: Adjust the position of the driver in Makefile.
> v9: Add static prefix for emif attributes macro
>     Update the kernel version of the sysfs interfaces in Doc.
> ---
>  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
>  drivers/memory/Kconfig                             |   9 +
>  drivers/memory/Makefile                            |   2 +
>  drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
>  4 files changed, 243 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
>  create mode 100644 drivers/memory/dfl-emif.c
>

I am confused now. This was already taken by Moritz, wasn't it? And
the dependencies were already taken, weren't they? Previously it was
depending on "Modularization of DFL private feature drivers" and "add
dfl bus support to MODULE_DEVICE_TABLE()"... now this is here so did
the dependencies change? What is the reason to include this patch
here?

My ack was for the purpose of taking it via Moritz tree, because of
the dependencies. If this is not the case, then probably better to
take it via memory controllers tree to avoid any conflicts (it's not a
small change).

Best regards,
Krzysztof
