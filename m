Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE2418402
	for <lists+linux-fpga@lfdr.de>; Sat, 25 Sep 2021 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhIYSlA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 25 Sep 2021 14:41:00 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:42956 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbhIYSlA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 25 Sep 2021 14:41:00 -0400
Received: by mail-pj1-f45.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so371855pjb.1
        for <linux-fpga@vger.kernel.org>; Sat, 25 Sep 2021 11:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LiVI1Pv3Wzg/ybXpGr81B2n7110Y2uNTC13w5IL/DzY=;
        b=k/RSDWgdyKTwd+SJRCjn4+U4IYjDQw8+XmIpZnKHOpuPNMCihXrCAlTrcU97qA2ZjD
         rO6qAXJsMm9WFn9F0YplZm0O3aOtTPtoHxpglL9OKSkPAc6JJ7CXWyPXxLhLoT77JJaZ
         2ZlPXbptjDd2Hf5Wj8dIzlasFsHsQklQnI3q1FdouWbegZ/d6suD+bylgYErtFfDljad
         Hrep4fWXnGo3tQB0DqgLyxkC17rSQs7gTy6NfznV2BzW23VRaSH8zOYeByDI9YAtKFih
         vtaiigMfFjUPQcacWkXKlYVP1bq+PdSGmw8AKvc2CxE7FgVdw4SfArMvYVcJfJDPcail
         Ivgw==
X-Gm-Message-State: AOAM531uC/rwujEy5zPcMBw5d0y9t3decEEPLugUiVmByEtbxBrqygZ7
        UOMX2pMZDli48s/jY/ZoHeE=
X-Google-Smtp-Source: ABdhPJzouyZdy8sLEmZ9OuqUO0eS6j98oE7Q4n/2my0+ciHdAo7hHn8nkmqLTxoye7KN8376Ddbntw==
X-Received: by 2002:a17:902:7e4c:b0:13d:e735:5783 with SMTP id a12-20020a1709027e4c00b0013de7355783mr8768896pln.17.1632595165232;
        Sat, 25 Sep 2021 11:39:25 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id v7sm12204864pff.195.2021.09.25.11.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 11:39:24 -0700 (PDT)
Date:   Sat, 25 Sep 2021 11:39:23 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, hao.wu@intel.com, yilun.xu@intel.com
Subject: Maintenance of Linux FPGA
Message-ID: <YU9s27qwyzmeONiq@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi all,

I lately did not have enough time to dedicate to the Linux FPGA
subsystem, concerns were raised around bus-factor and all.

Looking at my day-job I don't see this getting better in the short-term
so I've decided to get a conversation going on how to structure this
better for the benefit of the Linux FPGA subsystem.

Maybe a maintainer team approach would address the bus factor and
workload concerns better?

In terms of people I was thinking about:

Hao has done a great job at keeping the DFL part of things going, so I
think he'd be a great choice.

Yilun has been very helpful with reviews and I think he'd be a good
pick, too.

In terms of how to structure this: I'm not sure just yet, open to input.

How do other multi-maintainer subsystems operate? Ideas? Suggestions?

Let me know what you think,

Moritz
