Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5413C4875A
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Jun 2019 17:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFQPea (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Jun 2019 11:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfFQPea (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 Jun 2019 11:34:30 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99CCF208E4;
        Mon, 17 Jun 2019 15:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560785669;
        bh=yUX2CWtSAKeDv1RU+9w/k8KvVW4jlJY27MWnYxozSOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j3OD/pzxDeACIl0ZztD7NpyJUBtaH8onIb8gBTSl096moBM9pVoOYDXVFtEcPjegF
         O/R/mylR0GZBDBsLHSFC9u4Rgy4lCIIvAPlk4HwD3kOFj7bIOitrV/Gb0CW4T69G27
         bX5DyuJ+BCSikNCUmd7CdMbb+Aulb6MNmZrtnATU=
Received: by mail-ed1-f51.google.com with SMTP id p15so16748024eds.8;
        Mon, 17 Jun 2019 08:34:29 -0700 (PDT)
X-Gm-Message-State: APjAAAUDCz0iG869hHu9sDJfFZ+FFII1zKe3nTfVQYunwpVZ6Z6e15MH
        vXE2MHJn/tFlm3oL2/76tPQK+0UcU4GRY2QVrp4=
X-Google-Smtp-Source: APXvYqzCOXkvwPcWJEk6/a7G9wxosN19969+eIkHVk7gXjncQOJeib1+IDMy+/o2unGp70zpLGVjcu7VzCDX7F67g6U=
X-Received: by 2002:a50:a485:: with SMTP id w5mr27878889edb.277.1560785668200;
 Mon, 17 Jun 2019 08:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190617031113.4506-1-atull@kernel.org> <20190617033510.GA25342@archbook>
In-Reply-To: <20190617033510.GA25342@archbook>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 17 Jun 2019 10:33:51 -0500
X-Gmail-Original-Message-ID: <CANk1AXQTbMN2oDruwfS+NGtrKLMGJtp9R+2=o=yvwiuX1ebn9A@mail.gmail.com>
Message-ID: <CANk1AXQTbMN2oDruwfS+NGtrKLMGJtp9R+2=o=yvwiuX1ebn9A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: fpga: hand off maintainership to Moritz
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Richard Gong <richard.gong@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Jun 16, 2019 at 10:35 PM Moritz Fischer <mdf@kernel.org> wrote:

Hi Moritz,

>
> Hi Alan,
>
> On Sun, Jun 16, 2019 at 10:11:13PM -0500, Alan Tull wrote:
> > I'm moving on to a new position and stepping down as FPGA subsystem
> > maintainer.  Moritz has graciously agreed to take over the
> > maintainership.
>
> Thanks a lot for all the work you put into this, it was good fun working
> with you, and I hope you'll be back someday, or at least you'll keep
> working on the Linux Kernel in other areas.

Thank you for your support and all the good work and enthusiasm you've
put into this subsystem!

Alan

>
> All: It'll take me a bit to get everything sorted, since I just switched
> jobs and am still getting set up there, too, so please be patient :)
>
> > Signed-off-by: Alan Tull <atull@kernel.org>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 80e2bfa049d7..448730982545 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6266,7 +6266,6 @@ F:      include/linux/ipmi-fru.h
> >  K:   fmc_d.*register
> >
> >  FPGA MANAGER FRAMEWORK
> > -M:   Alan Tull <atull@kernel.org>
> >  M:   Moritz Fischer <mdf@kernel.org>
> >  L:   linux-fpga@vger.kernel.org
> >  S:   Maintained
> > --
> > 2.21.0
> >
>
> Cheers,
> Moritz
