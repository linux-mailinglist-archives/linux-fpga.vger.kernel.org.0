Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03E51FFAC4
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Jun 2020 20:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgFRSHu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Jun 2020 14:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbgFRSHt (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Jun 2020 14:07:49 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B712208DB;
        Thu, 18 Jun 2020 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592503668;
        bh=KA//1bD9BcrK8/lxvOXcCF+JQtiTauvjZLDS3E+OsfI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VwGa/w87tN4LTvCG5HLsX0B03TZZ05jRESXKSNMJlYy0Ut0/UfxI+I0BTQE5RY7lL
         JUm15MDTU8QuakLegL5rwjtyRBttfGR+X89EGRFe1pjW4oiqp4I+ikmNbcjg+KuTuI
         hJYCCO6Dzl+4CxEOo6DEvTxY2XU+INCx36cyAn4s=
Received: by mail-ot1-f52.google.com with SMTP id k15so5268545otp.8;
        Thu, 18 Jun 2020 11:07:48 -0700 (PDT)
X-Gm-Message-State: AOAM530Axh54Y9pFBspxp/Y216RzLEakIrcIZATcByCa9tB0IzsPbTyb
        kA3hXIxTl/ac+EXAJtNImmk7taojQ5Opfi9Opg==
X-Google-Smtp-Source: ABdhPJz0B3UsnGoEf/FA5KAGc6jI6UDS3zxzffe1y+bD6ZgajEpGsDIKeXrt/kD/1a+oLZt7rG9XGQuJH/Sw3DDtGNM=
X-Received: by 2002:a9d:3a36:: with SMTP id j51mr4707679otc.129.1592503667774;
 Thu, 18 Jun 2020 11:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200611211144.9421-1-luca@lucaceresoli.net> <20200611211144.9421-4-luca@lucaceresoli.net>
 <20200617223955.GA2967317@bogus> <b2c064c0-9a52-890d-b026-9cc1f4cab7d0@lucaceresoli.net>
In-Reply-To: <b2c064c0-9a52-890d-b026-9cc1f4cab7d0@lucaceresoli.net>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Jun 2020 12:07:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLCYdRci2W3otAwz_rDKQeFXuOdO0ZAv4fUGNZoiZb6hg@mail.gmail.com>
Message-ID: <CAL_JsqLCYdRci2W3otAwz_rDKQeFXuOdO0ZAv4fUGNZoiZb6hg@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: fpga: xilinx-slave-serial: add optional
 INIT_B GPIO
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 17, 2020 at 11:47 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> Hi Rob, Moritz,
>
> On 18/06/20 00:39, Rob Herring wrote:
> > On Thu, Jun 11, 2020 at 11:11:43PM +0200, Luca Ceresoli wrote:
> >> The INIT_B is used by the 6 and 7 series to report the programming status,
> >> providing more control and information about programming errors.
> >>
> >> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> >> ---
> >>  .../devicetree/bindings/fpga/xilinx-slave-serial.txt       | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> >> index 9f103f3872e8..a049082e1513 100644
> >> --- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> >> +++ b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
> >> @@ -16,6 +16,10 @@ Required properties:
> >>  - prog_b-gpios: config pin (referred to as PROGRAM_B in the manual)
> >>  - done-gpios: config status pin (referred to as DONE in the manual)
> >>
> >> +Optional properties:
> >> +- init_b-gpios: initialization status and configuration error pin
> >> +                (referred to as INIT_B in the manual)
> >
> > Don't use '_' in property names:
> >
> > init-b-gpios
>
> OK, will fix.
>
> Moritz, please don't apply this version of patches 4 and 5 if you still
> haven't done so.
>
> Now what about the existing prog_b-gpios property? Should we just leave
> it as is for backward compatibility, or is there a migration path to fix
> it as well?

Just leave it.

Rob
