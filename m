Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D65E4A407
	for <lists+linux-fpga@lfdr.de>; Tue, 18 Jun 2019 16:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfFROaF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 18 Jun 2019 10:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbfFROaE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 18 Jun 2019 10:30:04 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D4FD21479;
        Tue, 18 Jun 2019 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560868204;
        bh=qrGh8QmMAHY5D7lfxcxyW1W2MYQ27xZ+iv3w/FkGJYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q0LyzPLxIgHIEMpUNOWx5GmUsP9eHO+vomsvt3DWjPFP308P/W4k4GVLLDsA1Di6Z
         GLoNf3m1AMTbywxoTx4j1Et71C9dW6Ce6HEt1IaXAtwj8epMVyF/xNa3ted7eq5Wyx
         GYY93MWi1eqN/Fs+dtjSJZByw+vgF0slv4piIOSA=
Received: by mail-ed1-f53.google.com with SMTP id p15so22015562eds.8;
        Tue, 18 Jun 2019 07:30:04 -0700 (PDT)
X-Gm-Message-State: APjAAAW0B0EeDOzERl3O13Umzb6e1Gc4BV+4IVQ1zev0qSjtzZHuxD6g
        6pz2ak7OpIoR8wWDqT+senbXlnTMS60iI9moyZE=
X-Google-Smtp-Source: APXvYqw7lSFSu4b7VLHIRkNIMtAtb3UUorWS/RBTRM0Fu8WpXYbUxTDgNagTS4CciRrv/Hb7dLozVOZFNNliLBQpXV0=
X-Received: by 2002:a50:84a1:: with SMTP id 30mr21976093edq.44.1560868202728;
 Tue, 18 Jun 2019 07:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190617031113.4506-1-atull@kernel.org> <20190618071751.GA4159@kroah.com>
In-Reply-To: <20190618071751.GA4159@kroah.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 18 Jun 2019 09:29:25 -0500
X-Gmail-Original-Message-ID: <CANk1AXRq35TWCjsz_mFfecZ-9Yx5UCT9+NLGv3EWBC=r_KTJXg@mail.gmail.com>
Message-ID: <CANk1AXRq35TWCjsz_mFfecZ-9Yx5UCT9+NLGv3EWBC=r_KTJXg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: fpga: hand off maintainership to Moritz
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Richard Gong <richard.gong@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 18, 2019 at 2:17 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jun 16, 2019 at 10:11:13PM -0500, Alan Tull wrote:
> > I'm moving on to a new position and stepping down as FPGA subsystem
> > maintainer.  Moritz has graciously agreed to take over the
> > maintainership.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
>
> Thanks for all the work you have done on this subsystem getting it into
> mergable shape and then maintaining it for a while.
>
> good luck on your future endeavors, hopefully it still involves kernel
> programming :)

Thanks for all your guidance and help!

Alan

>
> greg k-h
