Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 555AA24030
	for <lists+linux-fpga@lfdr.de>; Mon, 20 May 2019 20:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbfETSWC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 May 2019 14:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfETSWC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 20 May 2019 14:22:02 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BF4521743;
        Mon, 20 May 2019 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558376521;
        bh=qVJmGbj2Vdd/g0/cuWy10JFLGcZpf14oBOXbCGQmSao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RndWrmIyDdQwqshRWRJYdMlqIrTsTZXDBnaDHWsmXWw+8OAGxhLpviiyi7aaXmXPG
         tgmLX73WuHT4WyfEFbi4TE7pkzFGoePNCGi1rG8IHt+Ckr8au5kbUa1jhiuIdx7nvo
         GIxN1w0bGZvAUcorLk3AU25aEkwa1cRNkmK958LI=
Received: by mail-ed1-f44.google.com with SMTP id b8so25193831edm.11;
        Mon, 20 May 2019 11:22:01 -0700 (PDT)
X-Gm-Message-State: APjAAAWM5p+PjKSc5nOtLUMvOEFPfN38zMhfA56rGgGTQVsey/uoYIUe
        Fwdn7HIGsVxTzXfjJclY+K1FtBW+VFPUfsQIDtk=
X-Google-Smtp-Source: APXvYqxBn56JZKTbqqS2rJEHEi0by3+14eci4UT/1x1JZqQKroM36bhraEHyozw5pF1jkWje0l3swnaHncZ6INr3GDY=
X-Received: by 2002:a50:9858:: with SMTP id h24mr29972423edb.147.1558376520094;
 Mon, 20 May 2019 11:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-6-git-send-email-hao.wu@intel.com> <CANk1AXQSL8k=FOLv4_rLfRHBqOi=CW=yP3O8ch4VEa25cj9+Cw@mail.gmail.com>
 <CANk1AXQCp2ozUQDWz__MuiUeDLvGvrfqj3KUYmBa5Z34oxG8NQ@mail.gmail.com> <20190517041116.GC20569@hao-dev>
In-Reply-To: <20190517041116.GC20569@hao-dev>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 20 May 2019 13:21:24 -0500
X-Gmail-Original-Message-ID: <CANk1AXTh+U-C9TxO7ZZTF+7Nu-_5i=G_0wK0FZ2Go55gPYR0Ng@mail.gmail.com>
Message-ID: <CANk1AXTh+U-C9TxO7ZZTF+7Nu-_5i=G_0wK0FZ2Go55gPYR0Ng@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] Documentation: fpga: dfl: add descriptions for
 virtualization and new interfaces.
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 16, 2019 at 11:27 PM Wu Hao <hao.wu@intel.com> wrote:
>
> On Thu, May 16, 2019 at 12:53:00PM -0500, Alan Tull wrote:
> > On Thu, May 16, 2019 at 12:36 PM Alan Tull <atull@kernel.org> wrote:
> > >
> > > On Mon, Apr 29, 2019 at 4:12 AM Wu Hao <hao.wu@intel.com> wrote:
> >
> > Hi Hao,
> >
> > Most of this patchset looks ready to go upstream or nearly so with
> > pretty straightforward changes .  Patches 17 and 18 need minor changes
> > and please change the scnprintf in the other patches.  The patches
> > that had nontrivial changes are the power and thermal ones involving
> > hwmon.  I'm hoping to send up the patchset minus the hwmon patches in
> > the next version if there's no unforseen issues.  If the hwmon patches
> > are ready then also, that's great, but otherwise those patches don't
> > need to hold up all the rest of the patchset.  How's that sound?
>
> Hi Alan
>
> Thanks for your time for reviewing this patchset.
>
> This sounds good to me. Only thing here is, I need to split the patch which
> updates documentation into 2 patches (to remove hwmon description in doc),
> but for sure, it should be very easy. :)

Yes that sounds good.

Thanks,
Alan


>
> Thanks
> Hao
>
> >
> > Alan
> >
> > > >
> > > > This patch adds virtualization support description for DFL based
> > > > FPGA devices (based on PCIe SRIOV), and introductions to new
> > > > interfaces added by new dfl private feature drivers.
> > > >
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > >
> > > Acked-by: Alan Tull <atull@kernel.org>
> > >
> > > Thanks,
> > > Alan
