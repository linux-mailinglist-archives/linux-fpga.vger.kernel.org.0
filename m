Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F1641A66E
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Sep 2021 06:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhI1EXv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Sep 2021 00:23:51 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:40862 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhI1EXv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 28 Sep 2021 00:23:51 -0400
Received: by mail-pg1-f179.google.com with SMTP id h3so19827357pgb.7
        for <linux-fpga@vger.kernel.org>; Mon, 27 Sep 2021 21:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BsJ8YDtqpT0ddJtHv+VE363rYF8gRO2Adp65H7Apimo=;
        b=b31Av4yAOXSWq7mq8CrDc1SaeFzkjY9sx4LAHI5cVT4E2+WMcngf8S0qyuPyNBI9k9
         b2622ybBe31/yev/iitwzPI5DlBXejIGSd1n+Lzc2GwE61aY+SUjPRCen3eaWZdJBHbY
         /x5irL0XNhWGmWL79sTdLxpDjBWy7IJRK+nQBFkdNFiW5rxmVJBZ21ugbcOt4vAGS6Sc
         i/97kjDQZzw1STEFOl2i4o8vnuJ9NDCvrbqz4dpYjibvUWnQg5Wq0h06+W0S14Ljccj+
         MX29QpR5NLEwqxrfNsoKu7Jkcm1f5BcXYSYsmQnceoG97mGgwTxcp+tHS/FGswr3CTp5
         GzZQ==
X-Gm-Message-State: AOAM532+9x9uYj5N5wh0KlmE1HmGFs2xBquzyV+OahNzAEfGXRl4pGbH
        7orKLqtIRGz1eEG8NeMAN8c=
X-Google-Smtp-Source: ABdhPJxDb9i5Ntb254wuSn5BETaUGjaEuM6rnRPoDaM47/5qPfeUGgGG6alptfuTOjWdGc9l5yL/wQ==
X-Received: by 2002:a63:7d0f:: with SMTP id y15mr2756629pgc.446.1632802932286;
        Mon, 27 Sep 2021 21:22:12 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id u10sm833874pjf.46.2021.09.27.21.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 21:22:11 -0700 (PDT)
Date:   Mon, 27 Sep 2021 21:22:10 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        gregkh@linuxfoundation.org, hao.wu@intel.com
Subject: Re: Maintenance of Linux FPGA
Message-ID: <YVKYcpbfui9WlWpQ@epycbox.lan>
References: <YU9s27qwyzmeONiq@epycbox.lan>
 <20210926054449.GD806603@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210926054449.GD806603@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Yilun,

On Sun, Sep 26, 2021 at 01:44:49PM +0800, Xu Yilun wrote:
> On Sat, Sep 25, 2021 at 11:39:23AM -0700, Moritz Fischer wrote:
> > Hi all,
> > 
> > I lately did not have enough time to dedicate to the Linux FPGA
> > subsystem, concerns were raised around bus-factor and all.
> > 
> > Looking at my day-job I don't see this getting better in the short-term
> > so I've decided to get a conversation going on how to structure this
> > better for the benefit of the Linux FPGA subsystem.
> > 
> > Maybe a maintainer team approach would address the bus factor and
> > workload concerns better?
> > 
> > In terms of people I was thinking about:
> > 
> > Hao has done a great job at keeping the DFL part of things going, so I
> > think he'd be a great choice.
> > 
> > Yilun has been very helpful with reviews and I think he'd be a good
> > pick, too.
> 
> It's my pleasure for the nomination and yes I'd like to be one of the
> maintainer team, to be more helpful.

Great, thanks for helping out. I'll look into setting up a shared
repository in the next couple of days.

In the meantime try getting a kernel.org account setup following the
instructions here: https://korg.docs.kernel.org/accounts.html

I don't remember if you have to be listed as M: entry in MAINTAINERS for
the account to get approved. In any case I'll send out a patch in a bit.

- Moritz
