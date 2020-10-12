Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A15628BEFF
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Oct 2020 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390745AbgJLR1m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Oct 2020 13:27:42 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:32902 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389613AbgJLR1m (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 12 Oct 2020 13:27:42 -0400
Received: by mail-ej1-f65.google.com with SMTP id c22so24356071ejx.0;
        Mon, 12 Oct 2020 10:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bXfdWwJ70rGKeWiHiVGGLR5+++oukZBshR02MSPwwGk=;
        b=ibZmvJD/K5OST4X6vO5CicqIdPPGYNb9BMHCgGxvU4LIZ65L7I3/jRJLqb8c58k500
         WCUKWa/CG+AqFcdaUv8PkLG4zgRRplaRtKWKHlEA7d7tryQKXXbqZe4f24WMaBLLcnYD
         S2m0CiGyg/wpeOAIY8qgVnPrjpJzPtSAzKMB6/oYwNGVodg0QnIfNxNh0WtM6dYgNeie
         Ay5lKZGJYAURinlME6chSRhMQH7OYzIgSSwHx25Uxoie3cIuTxo9P9HCuOX5OyaA4bLb
         vsKG3I9k/8nb13695KFPatlXPrydlyEuCc/TxW91yP2onsagpE1InSi79oC6hgYpnsUJ
         0Tnw==
X-Gm-Message-State: AOAM533qPkmx+ucvmvkmSnEpNZNKukggz4ch3u+LYBCqUOI/EBh002OU
        q+us+JbTghBuBMbhZP/jVGreHxPMoaE=
X-Google-Smtp-Source: ABdhPJx2FIpbI/LUxRyNnbEBrS+Joz1QQ83i9JBjfTKxvC+r9os3jnRRkhWLQR24PaMDY84fEEa0ew==
X-Received: by 2002:a17:906:34d1:: with SMTP id h17mr23937787ejb.87.1602523659738;
        Mon, 12 Oct 2020 10:27:39 -0700 (PDT)
Received: from kozik-lap ([194.230.155.215])
        by smtp.googlemail.com with ESMTPSA id g3sm10729358edy.12.2020.10.12.10.27.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Oct 2020 10:27:38 -0700 (PDT)
Date:   Mon, 12 Oct 2020 19:27:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v9 6/6] memory: dfl-emif: add the DFL EMIF private
 feature driver
Message-ID: <20201012172736.GA7225@kozik-lap>
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-7-git-send-email-yilun.xu@intel.com>
 <CAJKOXPcLbnvXJLa6G8Rpa8tLv4v22dDVPBDx4DrakPnbGdK4QA@mail.gmail.com>
 <20201012165803.GA2654@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012165803.GA2654@archbook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Oct 12, 2020 at 09:58:03AM -0700, Moritz Fischer wrote:
> Hi Krzysztof,
> 
> On Mon, Oct 12, 2020 at 06:40:46PM +0200, Krzysztof Kozlowski wrote:
> > On Sat, 10 Oct 2020 at 09:15, Xu Yilun <yilun.xu@intel.com> wrote:
> > >
> > > This driver is for the EMIF private feature implemented under FPGA
> > > Device Feature List (DFL) framework. It is used to expose memory
> > > interface status information as well as memory clearing control.
> > >
> > > The purpose of memory clearing block is to zero out all private memory
> > > when FPGA is to be reprogrammed. This gives users a reliable method to
> > > prevent potential data leakage.
> > >
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > > v2: Adjust the position of this driver in Kconfig.
> > >     Improves the name of the Kconfig option.
> > >     Change the include dfl-bus.h to dfl.h, cause the previous patchset
> > >      renames the file.
> > >     Some minor fixes and comment improvement.
> > > v3: Adjust the position of the driver in Makefile.
> > > v9: Add static prefix for emif attributes macro
> > >     Update the kernel version of the sysfs interfaces in Doc.
> > > ---
> > >  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
> > >  drivers/memory/Kconfig                             |   9 +
> > >  drivers/memory/Makefile                            |   2 +
> > >  drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
> > >  4 files changed, 243 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > >  create mode 100644 drivers/memory/dfl-emif.c
> > >
> > 
> > I am confused now. This was already taken by Moritz, wasn't it? And
> > the dependencies were already taken, weren't they? Previously it was
> > depending on "Modularization of DFL private feature drivers" and "add
> > dfl bus support to MODULE_DEVICE_TABLE()"... now this is here so did
> > the dependencies change? What is the reason to include this patch
> > here?
> 
> It is confusing. Basically Greg had comments on the patch after I had
> applied it. It's going through anothe round of review.
> 
> > 
> > My ack was for the purpose of taking it via Moritz tree, because of
> > the dependencies. If this is not the case, then probably better to
> > take it via memory controllers tree to avoid any conflicts (it's not a
> > small change).
> 
> Once it's ok I can put it on a branch with a stable tag and you can pull
> that in and take the patch through your tree.

I am not going to apply any new patches before end of merge window, so
if you can still push it to Greg for v5.10, then please take it. However
I think Greg also does not take patches during merge window, so most
likely this will wait for the next cycle. In such case let's do it via
stable tag for DFL parts.

Best regards,
Krzysztof
