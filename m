Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2286D276801
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 06:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgIXExQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 00:53:16 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50961 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIXExQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 24 Sep 2020 00:53:16 -0400
Received: by mail-pj1-f68.google.com with SMTP id fa1so1011038pjb.0;
        Wed, 23 Sep 2020 21:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qpLQEylf7V9Nzutns+p3Vp5V52QPP2PMMRwKiRQia2s=;
        b=Yi69gGUpPHe1ZEu5ltGpFwnmfHpLuu2CEeGDJNUGOGjp21FQwiEIkdHTfX1CwNBeUy
         +gMWn/IB3rjkjjVMDIvGYoxsxHL6ylElNgOdNuz9YWSr1ujGtEKvUWdGTZ49gYU1cZP9
         TrLakcGfnDEjs/7rrrCFAg7GTuc9A0hrqv7YoKWx+jAc9+8SrayupuKXeLw+9IZ4gR0w
         vXwQ9EMayWKMIMfkBBsMqqtaFYux1QoSBH3vlb+sMi/J4tJt5Xkc+Q6n7sGf79XTkqEp
         5WWE/M11v+oZlp93CESVCA2OEPlSKIr/9KGoRVyyG/y1ljP4tQDtIUeWvDSJbLbaNmMc
         qBFA==
X-Gm-Message-State: AOAM531/+6A4j2FgiTWHX+SH6R4jyC7b06ir+QyVLdFzWfp1Wb1bes5T
        utO20aaxvEoMTJABdmySf72N5XClxAE=
X-Google-Smtp-Source: ABdhPJzmb6rbFEmYm35Cp2vNybbyYDMin/HM/I8ORcRPZ3twGtzYy1P/Z6qvngNyY44jbF/TI4DdxA==
X-Received: by 2002:a17:90a:de92:: with SMTP id n18mr2323271pjv.35.1600923195618;
        Wed, 23 Sep 2020 21:53:15 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id il14sm880444pjb.54.2020.09.23.21.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 21:53:14 -0700 (PDT)
Date:   Wed, 23 Sep 2020 21:53:14 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Moritz Fischer <mdf@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: Re: [PATCH v2 0/6] clk: axi-clk-gen: misc updates to the driver
Message-ID: <20200924045314.GA91389@epycbox.lan>
References: <20200810134252.68614-1-alexandru.ardelean@analog.com>
 <20200810134252.68614-8-alexandru.ardelean@analog.com>
 <CA+U=Dsr41kKGXmgE1KjdTzAso3rwtNXAEoSy+Li=uym7G=D=Jw@mail.gmail.com>
 <20200915024138.GA1827@epycbox.lan>
 <160080374459.310579.14438590389388419207@swboyd.mtv.corp.google.com>
 <CA+U=DsrRo0t0Zit8ay5jytmCd5n=BcMHHbXpJMW90oAiur32+w@mail.gmail.com>
 <160090551301.310579.3934488165908158116@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160090551301.310579.3934488165908158116@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Stephen,

On Wed, Sep 23, 2020 at 04:58:33PM -0700, Stephen Boyd wrote:
> Quoting Alexandru Ardelean (2020-09-22 23:22:33)
> > On Tue, Sep 22, 2020 at 10:42 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Moritz Fischer (2020-09-14 19:41:38)
> > > > On Mon, Sep 14, 2020 at 11:11:05AM +0300, Alexandru Ardelean wrote:
> > > > > On Mon, Aug 10, 2020 at 4:41 PM Alexandru Ardelean
> > > > > <alexandru.ardelean@analog.com> wrote:
> > > > > >
> > > > > > These patches synchronize the driver with the current state in the
> > > > > > Analog Devices Linux tree:
> > > > > >   https://github.com/analogdevicesinc/linux/
> > > > > >
> > > > > > They have been in the tree for about 2-3, so they did receive some
> > > > > > testing.
> > > > >
> > > > > Ping on this series.
> > > > > Do I need to do a re-send?
> > >
> > > I got this patch series twice. Not sure why.
> > 
> > My fault here.
> > Some Ctrl + R usage and not being attentive with the arguments.
> > I think I added "*.patch" twice on the send-mail command.
> > I did something similar [by accident] for some DMA patches.
> > Apologies.
> > 
> > I can do a re-send for this, if it helps.
> 
> Sure. Please resend it.
> 
> > 
> > >
> > > >
> > > > I've applied the FPGA one, the other ones should go through the clock
> > > > tree I think?
> > >
> > > Doesn't patch 6 rely on the FPGA patch? How can that driver build
> > > without the header file?
> > 
> > Yes it does depend on the FPGA patch.
> > We can drop patch 6 for now, pending a merge to Linus' tree and then
> > wait for the trickle-down.
> > I don't mind waiting for these patches.
> > I have plenty of backlog that I want to run through, and cleanup and
> > then upstream.
> > So, there is no hurry.
> 
> Can you send me a signed tag with that patch? I can base this patch
> series on top of that. Or I can just apply it to clk tree and if nobody
> changes it in the meantime merge should work out in linux-next and
> linus' tree upstream.

Long story short I messed up my pull-request to Greg and had to back out
the patch anyways. In retrospect I think the patch should have gone
through your tree anyways, so here's our chance to get it right.

Feel free to take it with the rest of the changes through your tree.

Note: When I applied the patch I fixed up the whitespace that checkpatch
complained about so you might want to do that (or ask Alexandru to
resend the patch).

Acked-by: Moritz Fischer <mdf@kernel.org>

Sorry for the confusion and let me know if you still prefer a signed
tag.

- Moritz
