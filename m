Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E774E5B26B8
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Sep 2022 21:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiIHT3B (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Sep 2022 15:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiIHT3A (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Sep 2022 15:29:00 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A340CB532D;
        Thu,  8 Sep 2022 12:28:59 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id ml1so7795446qvb.1;
        Thu, 08 Sep 2022 12:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rtjCvFMzCSvxYl+KVbiv9tLwcN6J8Pm9uw37RRRl7gg=;
        b=p8E4JfUtzfT9wVWLIjZKq6B3xlI/3i6dQHGJVI6YrOKtZm6qUAEOBTQk5wTt/yh44I
         mSFJtUz0YjcZTaxHAsrhNyQCSdeUMUBm+f/kFTc0upKvLifovZLgNcXzBIIijUVerZIp
         7QAKYrB2fRoTWJ5L2Ak9Wus5RWC4Q+ck90WCC1PqCs8M1Yz7/kgeLbrzg8IlqVYBLl5h
         nCWblac+Wci1w2vtrfDMCDrgqQioglDh/HRxg3VOIcFuNhZp84HogT0GG1Jd7S2+chmv
         uPBO/9qaioPLwk8DaBdVWK7/l2kqwmfAVYLvLegEyW/vUKue6DmP67r5rHcwm2Eth4np
         kUcg==
X-Gm-Message-State: ACgBeo26UVIHgJCGkNsJxMSyEw0WJYiiKIFQIRYrV1Ck1KtSJPgVKpRd
        jJ4sk769eXHVVkZ0unHvyXr6NterjwG9OQ==
X-Google-Smtp-Source: AA6agR7s5p6HzyJHwRi9FzrwOUJiHuIJXnXeCwN3wBaIYXEI9uGZC6hdraz6FPzdZULkztCyT4HR4Q==
X-Received: by 2002:ad4:5d65:0:b0:4a4:cac:d56b with SMTP id fn5-20020ad45d65000000b004a40cacd56bmr9207035qvb.2.1662665338625;
        Thu, 08 Sep 2022 12:28:58 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 15-20020ac84e8f000000b0031f0b43629dsm15924814qtp.23.2022.09.08.12.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 12:28:57 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3450990b0aeso150101287b3.12;
        Thu, 08 Sep 2022 12:28:57 -0700 (PDT)
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr8834017ywc.316.1662665336860; Thu, 08
 Sep 2022 12:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-5-matthew.gerlach@linux.intel.com>
 <YxeqTdny7Nu7LzZo@smile.fi.intel.com> <alpine.DEB.2.22.394.2209071433320.3336870@rhweight-WRK1>
 <YxnMLI17XvjN74DW@smile.fi.intel.com> <alpine.DEB.2.22.394.2209081031450.61321@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2209081031450.61321@rhweight-WRK1>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Sep 2022 21:28:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWwRXKP51vX9KYjiwdZ9mUhsnLxkrAex+LwKpCw-H7=8A@mail.gmail.com>
Message-ID: <CAMuHMdWwRXKP51vX9KYjiwdZ9mUhsnLxkrAex+LwKpCw-H7=8A@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] fpga: dfl: add generic support for MSIX interrupts
To:     matthew.gerlach@linux.intel.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        russell.h.weight@intel.com, basheer.ahmed.muddebihal@intel.com,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>, Lukas Wunner <lukas@wunner.de>
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

On Thu, Sep 8, 2022 at 7:34 PM <matthew.gerlach@linux.intel.com> wrote:
> On Thu, 8 Sep 2022, Andy Shevchenko wrote:
> > On Wed, Sep 07, 2022 at 02:37:32PM -0700, matthew.gerlach@linux.intel.com wrote:
> >> On Tue, 6 Sep 2022, Andy Shevchenko wrote:
> >>> On Tue, Sep 06, 2022 at 12:04:25PM -0700, matthew.gerlach@linux.intel.com wrote:
> >
> > ...
> >
> >>>> +  if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
> >>>> +      fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
> >>>> +          v = readq(base);
> >>>> +          v = FIELD_GET(DFH_VERSION, v);
> >>>> +
> >>>> +          if (v == 1) {
> >>>> +                  v =  readq(base + DFHv1_CSR_SIZE_GRP);
> >>>
> >>> I am already lost what v keeps...
> >>>
> >>> Perhaps
> >>>
> >>>             v = readq(base);
> >>>             switch (FIELD_GET(DFH_VERSION, v)) {
> >>>             case 1:
> >>>                     ...
> >>>                     break;
> >>>             }
> >>
> >> How about?
> >>              if (FIELD_GET(DFH_VERSION, readq(base)) == 1) {
> >>                      ...
> >>              }
> >
> > This one tends to be expanded in the future, so I would keep it switch case.
> >
>
> I'm okay with using the switch statement, but how about the following?
>
>                 switch (FIELD_GET(DFH_VERSION, readq(base))) {
>                  case 1:
>                         ...
>                         break;
>                 }

Would it make sense to print an error if a newer version than 1 is detected?
BTW, what is the expected value when DFHv1 is not detected? Zero
or an arbitrary number?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
