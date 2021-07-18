Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407073CC735
	for <lists+linux-fpga@lfdr.de>; Sun, 18 Jul 2021 04:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhGRCDJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 17 Jul 2021 22:03:09 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:38487 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhGRCDH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 17 Jul 2021 22:03:07 -0400
Received: by mail-pf1-f179.google.com with SMTP id i14so894335pfd.5;
        Sat, 17 Jul 2021 19:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZFzP39M9iZaxx5c7vluzIRVcenkLvCX6Tkh+7bLeuTA=;
        b=RhEblqoGYwdLc3hxlbo+US0tZB3wRbETlreLOEIlO1Z+gMaPCr1U+QXt9BT1uHAlQ6
         MbEp8weqEJuSrSGbIEz8nVON6pnr7JJklbcsJB6L9Pg/8S27uvnW7CzJBgWOayUOk6rp
         iehAuwb4Slb5P+eOaFW0Tn0Vxh4hMpiPPMzYLrXav2GhXTtKA3uJDuGfu1SNLcoPOqCe
         fCq1B/pzDn5YVLC8YTlgRxlIOqkYPgtI1J/5z2j2/h5IENMBCfT3d5Stoj+1u8/29/Zs
         K7oxBG5zwQWq+lJkIoLkb122Mnq+OWdoh9/IIKyMhS5/O0Tg0pdiHeLFn8NHVJTRoltN
         Soig==
X-Gm-Message-State: AOAM530p2VvJpv/Hhs668X+GRAR0iXBfp0L2raceKDfjwVelokNnZpHe
        4ANXvxBwGdT19IpOm/3ZIFU=
X-Google-Smtp-Source: ABdhPJyG3ElGXJZOX/6F/ViVLj/DbOpr7gKRKBe9L/dy9QJFfg4/qzyutsiJo9xA0e2HRUE89ZJx2A==
X-Received: by 2002:a62:2bc6:0:b029:2cc:242f:ab69 with SMTP id r189-20020a622bc60000b02902cc242fab69mr18262108pfr.16.1626573609019;
        Sat, 17 Jul 2021 19:00:09 -0700 (PDT)
Received: from localhost ([24.4.24.239])
        by smtp.gmail.com with ESMTPSA id s36sm16094661pgk.64.2021.07.17.19.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 19:00:08 -0700 (PDT)
Date:   Sat, 17 Jul 2021 19:00:07 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] FPGA Manager address unused variable warnings
Message-ID: <YPOLJ6mg9WWQ9/gI@epycbox.lan>
References: <20210702035404.397853-1-mdf@kernel.org>
 <d0088161-ec7f-4ff4-d5c1-c0746ca17283@redhat.com>
 <20210707020309.GA12358@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707020309.GA12358@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 07, 2021 at 10:03:09AM +0800, Xu Yilun wrote:
> On Tue, Jul 06, 2021 at 09:28:37AM -0700, Tom Rix wrote:
> > 
> > On 7/1/21 8:54 PM, Moritz Fischer wrote:
> > > This patchset addresses a handful of warnings as result of_match_ids
> > > being not properly wrapped in #ifdef CONFIG_OF.
> > > 
> > > Moritz Fischer (4):
> > >    fpga: altera-freeze-bridge: Address warning about unused variable
> > >    fpga: xiilnx-spi: Address warning about unused variable
> > >    fpga: xilinx-pr-decoupler: Address warning about unused variable
> > >    fpga: zynqmp-fpga: Address warning about unused variable
> > > 
> > >   drivers/fpga/altera-freeze-bridge.c | 2 ++
> > >   drivers/fpga/xilinx-pr-decoupler.c  | 2 ++
> > >   drivers/fpga/xilinx-spi.c           | 2 ++
> > >   drivers/fpga/zynqmp-fpga.c          | 3 ++-
> > >   4 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > I am not seeing these warnings, but it is still worth doing.
> > 
> > I think a few more files need this change.
> > 
> > altera-ps-spi.c, dfl-n3000-nios.c, altera-hps2fpga.c, stratix10-soc.c,
> > socfpga-a10.c, altera-fpga2sdram.c
> 
> dfl-n3000-nios is not using of_device_id, and doesn't need the change.
> 
> Thanks,
> Yilun
> 
> > 
> > Not needed for
> > 
> > altera-pr-ip-core-plat.c and ice40-spi.c
> > 
> > These have depends on OF in Kconfig.
> > 
> > Tom

Applied to for-next,

Moritz
