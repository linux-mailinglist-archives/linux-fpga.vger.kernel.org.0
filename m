Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512F428BE8B
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Oct 2020 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbgJLQ6F (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Oct 2020 12:58:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44378 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390355AbgJLQ6F (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 12 Oct 2020 12:58:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id o3so4875135pgr.11;
        Mon, 12 Oct 2020 09:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k4OUtjq5lhgWhKFweGldJN253/ip0FkUL7lJYS0LP8k=;
        b=WzVgFomvL8wyw1tIYOsyUyyjoNF8Yte/hZPTeXmep4aWWfh4XzfQ3EW9/uD6IZTtj/
         OO4aKkjeUuPFXY9MuVUfEA7tKBzl6N7EHRY5WyVnODvByPmFmf36QJVsm9/uTd8X3Gun
         oQcDSOxwlQGos1OmaPaGw39JEYfZu7k+CKtjaoCUwaqobYZ/W87YLjQEJh+pDFIudL7h
         W/Jm8r69rwRxYh71swgPMqwAPbutg8oowZDtu2vm5mVsrJ0ZhO10ZGixAlSV4zQ7nq/C
         Cubhudpz93g899Wk61jZ1RH1vqDpeYLUo7A/bXHPH0u505OBxPjG/tad0Bwo2mMtPAsy
         VGbA==
X-Gm-Message-State: AOAM532KkEwKzOn8HLRF72pJHtw03HyIWwWHhTmtRNxPTlGn8hBhOqZL
        igAGIApKcph4/aT8N/AtYHw=
X-Google-Smtp-Source: ABdhPJz80xR0oT8apEleLqIMeto85pAjVJY6u6I/kCvyhnCU03ERwoIoNJwOmvSgzdzZsPR/GqUl1A==
X-Received: by 2002:a63:4854:: with SMTP id x20mr14476237pgk.220.1602521884486;
        Mon, 12 Oct 2020 09:58:04 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id q5sm8694300pjg.0.2020.10.12.09.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 09:58:03 -0700 (PDT)
Date:   Mon, 12 Oct 2020 09:58:03 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v9 6/6] memory: dfl-emif: add the DFL EMIF private
 feature driver
Message-ID: <20201012165803.GA2654@archbook>
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-7-git-send-email-yilun.xu@intel.com>
 <CAJKOXPcLbnvXJLa6G8Rpa8tLv4v22dDVPBDx4DrakPnbGdK4QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPcLbnvXJLa6G8Rpa8tLv4v22dDVPBDx4DrakPnbGdK4QA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Krzysztof,

On Mon, Oct 12, 2020 at 06:40:46PM +0200, Krzysztof Kozlowski wrote:
> On Sat, 10 Oct 2020 at 09:15, Xu Yilun <yilun.xu@intel.com> wrote:
> >
> > This driver is for the EMIF private feature implemented under FPGA
> > Device Feature List (DFL) framework. It is used to expose memory
> > interface status information as well as memory clearing control.
> >
> > The purpose of memory clearing block is to zero out all private memory
> > when FPGA is to be reprogrammed. This gives users a reliable method to
> > prevent potential data leakage.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> > v2: Adjust the position of this driver in Kconfig.
> >     Improves the name of the Kconfig option.
> >     Change the include dfl-bus.h to dfl.h, cause the previous patchset
> >      renames the file.
> >     Some minor fixes and comment improvement.
> > v3: Adjust the position of the driver in Makefile.
> > v9: Add static prefix for emif attributes macro
> >     Update the kernel version of the sysfs interfaces in Doc.
> > ---
> >  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
> >  drivers/memory/Kconfig                             |   9 +
> >  drivers/memory/Makefile                            |   2 +
> >  drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
> >  4 files changed, 243 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> >  create mode 100644 drivers/memory/dfl-emif.c
> >
> 
> I am confused now. This was already taken by Moritz, wasn't it? And
> the dependencies were already taken, weren't they? Previously it was
> depending on "Modularization of DFL private feature drivers" and "add
> dfl bus support to MODULE_DEVICE_TABLE()"... now this is here so did
> the dependencies change? What is the reason to include this patch
> here?

It is confusing. Basically Greg had comments on the patch after I had
applied it. It's going through anothe round of review.

> 
> My ack was for the purpose of taking it via Moritz tree, because of
> the dependencies. If this is not the case, then probably better to
> take it via memory controllers tree to avoid any conflicts (it's not a
> small change).

Once it's ok I can put it on a branch with a stable tag and you can pull
that in and take the patch through your tree.

Does that work?

Sorry for the mess,

Moritz
