Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7DC486F3F
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Jan 2022 01:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbiAGA6d (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Jan 2022 19:58:33 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:58897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiAGA6c (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Jan 2022 19:58:32 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MryCb-1mZLl547mP-00nwrQ; Fri, 07 Jan 2022 01:58:31 +0100
Received: by mail-wr1-f51.google.com with SMTP id w20so8022640wra.9;
        Thu, 06 Jan 2022 16:58:30 -0800 (PST)
X-Gm-Message-State: AOAM533zWTLAKMEcV7Uo4P0bzAv8Pl25ySMtGdb3pt4sLeBzs6VA0O+O
        jRm8vXoyMA6yUCH8jYkClWheiSxbD/xJDS4FTJc=
X-Google-Smtp-Source: ABdhPJw358xnVBy0xVmQn6spXwbuORRrv/Zlnm9a5imL/72/70FXovvZLsKseIasTfU7fEcAA/3bt/0PrbYZH1MsmmA=
X-Received: by 2002:a5d:6d0e:: with SMTP id e14mr54689312wrq.407.1641517110623;
 Thu, 06 Jan 2022 16:58:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <4a0a48fb682d13e6861f604d3cad3424672bee1f.1641500561.git.christophe.jaillet@wanadoo.fr>
 <CAK8P3a0MfHbB8ZFuTJpbVwPLZ-9QY-MWRFGukW1S4rbBBuDRzw@mail.gmail.com>
In-Reply-To: <CAK8P3a0MfHbB8ZFuTJpbVwPLZ-9QY-MWRFGukW1S4rbBBuDRzw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Jan 2022 19:58:28 -0500
X-Gmail-Original-Message-ID: <CAK8P3a01EyEzJKyk2upmvXW-VEb6XRGZgeBwEzH=jJYYL3saGg@mail.gmail.com>
Message-ID: <CAK8P3a01EyEzJKyk2upmvXW-VEb6XRGZgeBwEzH=jJYYL3saGg@mail.gmail.com>
Subject: Re: [PATCH 03/16] fpga: dfl: pci: Remove usage of the deprecated
 "pci-dma-compat.h" API
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, hao.wu@intel.com,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:S2NrGVuAJNeavdPuhHi9VbemRQp6gLroIRh+i6dxMTncWt+j5Yc
 jlCd6sEKAnBguUUv9AR5mN5Pz/+8b3+1c6O7ZJ2bq46mz9/R2mqUk1K4aTeLdTgmKatDoyN
 HN0AsO5Gwu41LWyyEb4Cvf6axNMvmWLYUp11hmSqUJiNla9KsdeiQd/wPLeuyu+qBGdrnaf
 vOPTfS5s4K/R8YugX3V7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kLzSUkWBejc=:2M0yazoBlemnF4JFCIolbg
 LtdWTHkqJR+p7X0meRzANwVwWSent5vC/A2GBcgjjm4kvxsn/lEZ8Id9LvkyqV+QqcjelIZy5
 AnpQZ+EN5xgyNp2qFXRDATPszv1V62+5RxYOXcuDS297StNZYLqZrOQIwcxd9QvNP+vPZE2MX
 14sJzumOVGwo6tnCS5METHD/DgW84a8Uvld2+nxwV+CM51DVVVgfyjy680CcXsiQ3utvmfYNt
 OZo43mHMg4qADe80bwQC/QrNZzFmwnQOSF6xAjZwKEamtBU+6pkonDCzjXTlYNXrLjxYu6cwS
 yGEHLQTrqbZVIZMtLxCv+ia/iFfJIWCXA+znHvJQ/vnvT6lbz0Oie4PJkk20e4W75P5l9qut1
 O1BYoBr7NtGnKqqSZRePkZ71oU6MgjzIYU9mEJEUyiJh+A7lrSi98fxDMaYceLJ5OipeR7DKC
 KogiB4jle/K2wWOgxcP/A/GBZ3uG8U9phgrPAoI9sch9akAxL58+9Yeue5LcbReM6S1+NhZ4N
 b3tx/0AMk1qECz8QZW2BOJkQMHBwoHzDGixRMAbTT8nimtXH7XEhJ3i0X7BcMFlGmu7votXF8
 C7RIeWgXoVARwqZOyBlsTR1zGiQ3U6iquPUhwzrAmqfLlb2+E/CXslAAbpBB6NGtbQrspG24h
 7BWIHWxgC9Rkg9CheBx2ZHf/E5+hYpO7dAbBoeU0cESCpUfh0YYAQZfiCsU+l8UubdDVAHaof
 sFLChQTggOwvPVoOnsFYoWuwiX4MElU3Tr2dExk9UeyIBjf8oA8Pvydncg0Xr8NQLMSF8UDRj
 EIktJi25XRxl7wTe+lDjF+NaD3xVsUn6g9li79pGiuQ+/ZRqKI0iif/QSjU14r2/LIBmPm9s6
 KJhn81H04aR2DtnkLeRFwX13MrLR0Z6zkLKQxrHM3/zEhfdjeF2oyhTBjYofLnv7bt84Kz3tq
 h3l+lRcIb3w==
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jan 6, 2022 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
>

> > [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> > [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
> > [3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Reviewed-by: Xu Yilun <yilun.xu@intel.com>
>
> This is a correct conversion of the driver, but I'd prefer to keep this separate
> from the pci-dma-compat series.

Nevermind, I just misread the patch, and it is required after all to get
rid of pci_set_dma_mask()

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
