Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C6A3579E5
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Apr 2021 03:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhDHBvi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Apr 2021 21:51:38 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:38471 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHBvh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Apr 2021 21:51:37 -0400
Received: by mail-pf1-f174.google.com with SMTP id y16so648428pfc.5
        for <linux-fpga@vger.kernel.org>; Wed, 07 Apr 2021 18:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1BN86ncl7yqpB/w0o6EiyjCdP08ric3ScWcOGr6K3FM=;
        b=G8QV+6b6Pl360AdjFK+iPwv263hJdSslP772dn14QkVrB99hMPT1c68EV3feiemJVw
         EPEpBQxzJ/f4K68Vf2FRYQ7zsKZkW3h4gL16qROl3ycT2U5K8jxLYz6eJTlxlEuqz132
         madbluWub9FKay2A1nr5INxFhizpeX4/PV7gPz3Di+JzUX+EvEgI8kIewL2YNQkUhDGD
         ZGZDjfFBW73cEfcpDJ/G7Ul+5UWQA/5qlMeVcH5GFVZO7Y0TN3UFrj96f6c3hI2oYvEj
         YMzqi6w3X7wmRna8yO6cnKMup3/cSHzC93nfQRfBuAiUec2W+eVwU4H+RA+ha0LiC96q
         4yMA==
X-Gm-Message-State: AOAM531GT1DChVuz00IgGDOIA6fJedX3zR/K+A4fgxcV2ZEbvAxTHE/G
        CDslSa37CAppB8nC+dcIHQY=
X-Google-Smtp-Source: ABdhPJwXLy/bXiIijuPzExjk49kEIq0K+QQrYwWBvUNSCfAT17y+P0VPkxfmu75u6dPsWfanx9vIiA==
X-Received: by 2002:a63:1266:: with SMTP id 38mr5918487pgs.427.1617846686930;
        Wed, 07 Apr 2021 18:51:26 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id y19sm10016702pge.50.2021.04.07.18.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 18:51:26 -0700 (PDT)
Date:   Wed, 7 Apr 2021 18:51:27 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Moritz Fischer <moritz.fischer.private@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager addtional 5.13 changes
Message-ID: <YG5hny8s2kviLOil@archbook>
References: <YG5g2KNJiDU37E8+@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG5g2KNJiDU37E8+@archbook>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Apr 07, 2021 at 06:48:08PM -0700, Moritz Fischer wrote:
> The following changes since commit 6f1e376cfc6864a2f46538db909bbd5253c3c146:
> 
>   fpga: Add support for Xilinx DFX AXI Shutdown manager (2021-03-06 07:54:40 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-late-for-5.13
> 
> for you to fetch changes up to a78a51a851ed3edc83264a67e2ba77a34f27965f:
> 
>   fpga: dfl: pci: add DID for D5005 PAC cards (2021-04-05 17:46:56 -0700)
> 
> ----------------------------------------------------------------
> Second set of FPGA Manager changes for 5.13-rc1
> 
> FPGA Manager:
> - Russ' first change improves port_enable reliability
> - Russ' second change adds a new device ID for a DFL device
> - Geert's change updates the examples in binding with dt overlay sugar
>   syntax
> 
> All patches have been reviewed on the mailing list, and have been in the
> last linux-next releases (as part of my for-next branch) without issues.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       dt-bindings: fpga: fpga-region: Convert to sugar syntax
> 
> Russ Weight (2):
>       fpga: dfl: afu: harden port enable logic
>       fpga: dfl: pci: add DID for D5005 PAC cards
> 
>  .../devicetree/bindings/fpga/fpga-region.txt       | 187 ++++++++++-----------
>  drivers/fpga/dfl-afu-error.c                       |  10 +-
>  drivers/fpga/dfl-afu-main.c                        |  35 ++--
>  drivers/fpga/dfl-afu.h                             |   2 +-
>  drivers/fpga/dfl-pci.c                             |  18 +-
>  5 files changed, 127 insertions(+), 125 deletions(-)

Ugh, sorry, let me resend this with correct sender ... I was messing
with my local mail setup ...

Moritz
