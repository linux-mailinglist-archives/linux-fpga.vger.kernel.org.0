Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9D1FFFC1
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Jun 2020 03:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgFSBhn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Jun 2020 21:37:43 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35537 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgFSBhn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 18 Jun 2020 21:37:43 -0400
Received: by mail-il1-f194.google.com with SMTP id l6so7894291ilo.2;
        Thu, 18 Jun 2020 18:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eAZuGyOCUcDGHINX2PjuvDVGtEm9kqJQdEnXysFjpws=;
        b=tWZ16tPY6KlihPIbS2zaCXViZk2/DuQHUr0tzSnzMSoJehcVkFHgjtSNHRaeQhvFFV
         y/PV7OlC4VWix8qSGo+WaHDcn/IYg8E3RaiAiuQqZY4yyRPMgyjnV9yj2QduXHlExolK
         8Kn19bY4moXuNJ1bfyejnoSVAT5Vyq5CTwcRo1BrtrAFkyDLCaD4Qp4QRvV0INMReapf
         97z9K3cPbsaTwZScJ+J4jGi32XB1QsXLRgzvScD7WkZAjpeSOoIaPrxtW1Kcab0++HZf
         ePnbRSxbmNeQjlxcJUPXj8SUlOyxZmKxr9cQh2egiORjvhTUoXIjTH12UiMnRP31aj8d
         nplg==
X-Gm-Message-State: AOAM5326IBkGiwR41WkHzX6hS3Wh/UDeIEIPGQROqZxzMVu7jidHusZ1
        PRWBWePDgSVRZa2ace1dzhUrwhYhlZ8=
X-Google-Smtp-Source: ABdhPJz5WKD2GJFTKbjZdXgRBc5OLyvEKmwOdNWmzub07kHtawv2Fz7DCjunIOTasR1YrjYIsxcNMA==
X-Received: by 2002:a92:dacf:: with SMTP id o15mr1339712ilq.36.1592530662192;
        Thu, 18 Jun 2020 18:37:42 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id z16sm2385916ilz.64.2020.06.18.18.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:37:40 -0700 (PDT)
Date:   Thu, 18 Jun 2020 18:37:39 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Anatolij Gustschin <agust@denx.de>,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Moritz Fischer <mdf@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: fpga: xilinx-slave-serial: valid for
 the 7 Series too
Message-ID: <20200619013739.GA3685@epycbox.lan>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
 <20200617223841.GA2967136@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617223841.GA2967136@bogus>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 17, 2020 at 04:38:41PM -0600, Rob Herring wrote:
> On Thu, 11 Jun 2020 23:11:40 +0200, Luca Ceresoli wrote:
> > The Xilinx 7-series uses the same protocol, mention that.
> > 
> > Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> > ---
> >  .../devicetree/bindings/fpga/xilinx-slave-serial.txt     | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to for-next,

Thanks
