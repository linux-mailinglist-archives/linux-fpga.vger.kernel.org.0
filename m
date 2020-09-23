Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0472764CD
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 01:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIWX6f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Sep 2020 19:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgIWX6f (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Sep 2020 19:58:35 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D2B8214F1;
        Wed, 23 Sep 2020 23:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600905514;
        bh=LN6CPAC6BCflrmJR9bhTiAiupB3OJMrSeNoGHcSpR38=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XLwsMBNz9F3ph/7uyntu0PYtN9X9f0qJBVSKc5HOA+UW5JYCZydQTYJpWP/0m9Ql4
         IEvCoE/wjQ6gCd0nr+hYjbwDWwMo0iyadE+Lva3XSgcALk7wh3k3RlhP7Q8o0SFyDv
         YU1NbBsnwCANEO3r1in3tP30G446QJ2lQvZUetqY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+U=DsrRo0t0Zit8ay5jytmCd5n=BcMHHbXpJMW90oAiur32+w@mail.gmail.com>
References: <20200810134252.68614-1-alexandru.ardelean@analog.com> <20200810134252.68614-8-alexandru.ardelean@analog.com> <CA+U=Dsr41kKGXmgE1KjdTzAso3rwtNXAEoSy+Li=uym7G=D=Jw@mail.gmail.com> <20200915024138.GA1827@epycbox.lan> <160080374459.310579.14438590389388419207@swboyd.mtv.corp.google.com> <CA+U=DsrRo0t0Zit8ay5jytmCd5n=BcMHHbXpJMW90oAiur32+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] clk: axi-clk-gen: misc updates to the driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 23 Sep 2020 16:58:33 -0700
Message-ID: <160090551301.310579.3934488165908158116@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Quoting Alexandru Ardelean (2020-09-22 23:22:33)
> On Tue, Sep 22, 2020 at 10:42 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Moritz Fischer (2020-09-14 19:41:38)
> > > On Mon, Sep 14, 2020 at 11:11:05AM +0300, Alexandru Ardelean wrote:
> > > > On Mon, Aug 10, 2020 at 4:41 PM Alexandru Ardelean
> > > > <alexandru.ardelean@analog.com> wrote:
> > > > >
> > > > > These patches synchronize the driver with the current state in the
> > > > > Analog Devices Linux tree:
> > > > >   https://github.com/analogdevicesinc/linux/
> > > > >
> > > > > They have been in the tree for about 2-3, so they did receive some
> > > > > testing.
> > > >
> > > > Ping on this series.
> > > > Do I need to do a re-send?
> >
> > I got this patch series twice. Not sure why.
>=20
> My fault here.
> Some Ctrl + R usage and not being attentive with the arguments.
> I think I added "*.patch" twice on the send-mail command.
> I did something similar [by accident] for some DMA patches.
> Apologies.
>=20
> I can do a re-send for this, if it helps.

Sure. Please resend it.

>=20
> >
> > >
> > > I've applied the FPGA one, the other ones should go through the clock
> > > tree I think?
> >
> > Doesn't patch 6 rely on the FPGA patch? How can that driver build
> > without the header file?
>=20
> Yes it does depend on the FPGA patch.
> We can drop patch 6 for now, pending a merge to Linus' tree and then
> wait for the trickle-down.
> I don't mind waiting for these patches.
> I have plenty of backlog that I want to run through, and cleanup and
> then upstream.
> So, there is no hurry.

Can you send me a signed tag with that patch? I can base this patch
series on top of that. Or I can just apply it to clk tree and if nobody
changes it in the meantime merge should work out in linux-next and
linus' tree upstream.
