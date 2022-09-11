Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32E75B506E
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 19:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIKRyd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 13:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIKRyd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 13:54:33 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F043B4B;
        Sun, 11 Sep 2022 10:54:31 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id d15so4637726qka.9;
        Sun, 11 Sep 2022 10:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=B4bddbQD1NbE7kocxVXmEn8/Skat8LorcHj/QVJVqFM=;
        b=1IuQqP4skRTNi4CrqTKPyg6uLxf6FNJ3ZO9JDNEt28VRSfkSA5+ivGUT1kvg2e11iI
         XhpqwVNsOxhLmiI//v/i2uCo0d1kBjdBXTpIMlcQ2d0tgdh4akSsWgLUWdPFVxUEnMvr
         roIFwFFIwTKCrdkkBDaftw5K3azIqx0OsfgrY9guMzDywyJMsWzYqE89Z4qYUo7Hflkq
         139sA5RRT6W+4qG2C/GAUvwM8q3gkkrLf7/CtNoi83nvm1VsWWO3vQfnzv7J2b2O9ODC
         Fs7o+cMKlvbJ44s2B18X3ei2MWFsCrXwp7t8Aij/9ThdmkhbIEaZemngSS3o7gPcqtDN
         6YtA==
X-Gm-Message-State: ACgBeo1urJrt24HkPl88M0jE+SrE67MbcAChF/bJH8Lq6ZTGJXSsCHjP
        1jPogAznLFeOrL7w3dbNeMcYknZLl4rHvQpu
X-Google-Smtp-Source: AA6agR6JODAm8vBbJi1aZlAuJClEHNM7UjEvPFcFcVeUHA4WZXPkd18EJTfNZ46nzMZeN76erh4J7A==
X-Received: by 2002:a05:620a:410b:b0:6ce:1edb:35f6 with SMTP id j11-20020a05620a410b00b006ce1edb35f6mr2009214qko.313.1662918870221;
        Sun, 11 Sep 2022 10:54:30 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id fu27-20020a05622a5d9b00b003434d3b5938sm5084745qtb.2.2022.09.11.10.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 10:54:29 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3452214cec6so76058657b3.1;
        Sun, 11 Sep 2022 10:54:29 -0700 (PDT)
X-Received: by 2002:a81:c52:0:b0:344:f9ca:89c4 with SMTP id
 79-20020a810c52000000b00344f9ca89c4mr19411353ywm.384.1662918869384; Sun, 11
 Sep 2022 10:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-3-matthew.gerlach@linux.intel.com>
 <YxgnOYWCSP7ormvK@kroah.com> <alpine.DEB.2.22.394.2209110838470.142336@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2209110838470.142336@rhweight-WRK1>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 11 Sep 2022 19:54:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUpS0C=LX+hgnM4M=j1KyFV2r9q-72qw9sq3QnhLz0gbg@mail.gmail.com>
Message-ID: <CAMuHMdUpS0C=LX+hgnM4M=j1KyFV2r9q-72qw9sq3QnhLz0gbg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] fpga: dfl: Move the DFH definitions
To:     matthew.gerlach@linux.intel.com
Cc:     Greg KH <gregkh@linuxfoundation.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, Jonathan Corbet <corbet@lwn.net>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Matthew,

On Sun, Sep 11, 2022 at 5:40 PM <matthew.gerlach@linux.intel.com> wrote:
> On Wed, 7 Sep 2022, Greg KH wrote:
> > On Tue, Sep 06, 2022 at 12:04:23PM -0700, matthew.gerlach@linux.intel.com wrote:
> >> --- a/drivers/fpga/dfl.h
> >> +++ b/drivers/fpga/dfl.h
> >> @@ -2,7 +2,7 @@
> >>  /*
> >>   * Driver Header File for FPGA Device Feature List (DFL) Support
> >>   *
> >> - * Copyright (C) 2017-2018 Intel Corporation, Inc.
> >> + * Copyright (C) 2017-2022 Intel Corporation, Inc.
> >
> > I'm all for updated proper copyright dates, but in a patch that
> > _removes_ text from a file does not seem like the proper place for that,
> > right?  Please discuss with your corporate lawyers as to how to do this
> > properly and when to do it.

> I discussed how and when to do this properly with my corporate lawyers and
> confirmed this submission is consistent with their guidelines.
>
> You do raise an interesting point, though.  If you think this approach is
> improper, we should probably discuss it, including whether this
> restriction is already a condition for contributions or whether it should
> be.  It wouldn't be the first difference of opinion on the finer points of
> copyright law.

So each time code is removed from a file, its copyright year should
be updated? Eventually, we may end up with an empty file which
is copyrighted <this_year>? Do you think that makes sense?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
