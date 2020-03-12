Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8C6183AB7
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Mar 2020 21:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgCLUjO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Mar 2020 16:39:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47055 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLUjO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 12 Mar 2020 16:39:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id a22so6943185oid.13;
        Thu, 12 Mar 2020 13:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cRa2w+BL3FKWs5JBsw59IEd0htTpOEDeGprZhPXR1xo=;
        b=lTOZzc6DUQV4IcvvgCNoGUpvkgJXKYbNCX5YuEQI86iOeWut1CYhtP6HITtiH4S8BO
         deuUGZxNru/1JZtJ60itAkNFNcnvBhat4734eg7hTXUsQtb3U9A7Q9uqR9FBfePzGxLG
         4WhvDWcv4SXNBwdQWr0N+N8k4VKyHFQX5XqBNWk2LDImzVZkXo0ZBgufhlVU/GqLVr1n
         N6xy70tUEVNGpWOCAC7ISiiT8mUUWrhDsrRTcjxwkukokxBOEGioXNSNoi0FgMvUeEom
         +hDnuQ/H2bVBSIuK2Kf8+dv460xVnClFz56rDKHic5OvWF8uiKab9R8XzJbx07EVZhXg
         TMkA==
X-Gm-Message-State: ANhLgQ1hdnocMAjd2yYt/Ei6DH1nVvaEgZYC8u9UVDeeYb5/aqa/ulEL
        e9vm1YalmWgGJ5UXVgO8WrMT88Y=
X-Google-Smtp-Source: ADFU+vsrUGG1iHJNbzBjSCrmrjOd9T3cZATSAkm8L16tyapXwaIRuDTh145NCYBaDCFlAIpARX+Gmg==
X-Received: by 2002:aca:1a17:: with SMTP id a23mr4010994oia.84.1584045553613;
        Thu, 12 Mar 2020 13:39:13 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p18sm18078134otl.70.2020.03.12.13.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:39:13 -0700 (PDT)
Received: (nullmailer pid 32741 invoked by uid 1000);
        Thu, 12 Mar 2020 20:39:11 -0000
Date:   Thu, 12 Mar 2020 15:39:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        ley.foon.tan@intel.com, robh+dt@kernel.org, mdf@kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 2/2] arch: nios2: remove 'resetvalue' property
Message-ID: <20200312203911.GA32682@bogus>
References: <20200306115450.3352-1-alexandru.ardelean@analog.com>
 <20200306115450.3352-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306115450.3352-2-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 6 Mar 2020 13:54:50 +0200, Alexandru Ardelean wrote:
> The 'altr,pio-1.0' driver does not handle the 'resetvalue', so remove it.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 -
>  arch/nios2/boot/dts/10m50_devboard.dts                 | 2 --
>  2 files changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
