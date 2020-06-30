Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3026320FA56
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Jun 2020 19:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgF3RRT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Jun 2020 13:17:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35170 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgF3RRS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 30 Jun 2020 13:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593537437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=18z1oTfW6/6D2G9GMiQYrGSxrdgHa1a8U8kk2US/2Lw=;
        b=Jp7pgI2aBYSwe/4MukV8vZHcc6xyKD7D5ZSTfnAqkqVCB/Yml7twicVcam95dFY35D9n8y
        lT6gbdR5REtltEWDzoHqZajrH1XXhR0Q6tMNitAePIpfJ4685ufsFn9V0kUct9LVtqVgRh
        V8iawCSzirZ7qgP7dMnt2U3LSU/wXLc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-112KhlBPNjiVKrVX6X-vGg-1; Tue, 30 Jun 2020 13:17:15 -0400
X-MC-Unique: 112KhlBPNjiVKrVX6X-vGg-1
Received: by mail-qt1-f197.google.com with SMTP id m25so10375159qtk.1
        for <linux-fpga@vger.kernel.org>; Tue, 30 Jun 2020 10:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=18z1oTfW6/6D2G9GMiQYrGSxrdgHa1a8U8kk2US/2Lw=;
        b=apEJTKqCmGiK1WtJKazgzsybiZ/gIsWl9P4XqQMTjL8SHVuCPk645g7BO4Gs7N2JGW
         NNiLspxZgp9R9hWyZ8zLCoem+YgjVjvBc0+Plz7TdTcnaHDDsSsuMjoRBjQyLa0n2c67
         9YmVQVp5sU3vJUBaGqUFcFG9rxHYrvGFLTVoQ71E6X/eRogOIfjb0taXOUEj5vkXA9qO
         mvj+Nrz86tHWCbjjUJZIQ0z3ni2iEez6lCvzll6LT27rqzVFzjo3HaBUSihH6FR++VYX
         BUPgc12nKqSpHA2ZTzaz7RZIf8pncD3ZPNHx3XB5xd+UHGfEAkQ+lncNHw2ROlBgjge0
         Wlag==
X-Gm-Message-State: AOAM531RyMsTzJomrYt7XzuMBg5s9NPlgn9PdMD9cnv0JmZV5EEpIibH
        kkxS/JulLgnl333n7jVlp0EvD7Z28dah8zR2dS4czlsU0PMYazumtTSbtaSh4+P4LHYONNHWg+F
        xivAzVjx3SSOsfXAK4dMiZg==
X-Received: by 2002:ad4:41c1:: with SMTP id a1mr16057966qvq.25.1593537435221;
        Tue, 30 Jun 2020 10:17:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2DSkUrLBgyp7sHt5BFKSklM1kXVf1p88R0WlPlVzruBd3JtL6CyW5QP11XrQjT62wlYI7Wg==
X-Received: by 2002:ad4:41c1:: with SMTP id a1mr16057919qvq.25.1593537434850;
        Tue, 30 Jun 2020 10:17:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w44sm3790774qtb.22.2020.06.30.10.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:17:14 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [RFC 0/1] fpga: dfl: RFC PCI config
Date:   Tue, 30 Jun 2020 10:16:55 -0700
Message-Id: <20200630171656.20151-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This configury shows where I would like the dfl pci cards to go
by introducing future cards as well as the current pac 10 card.

The goal is to fully configure the card in the drivers/fpga
area of the config.  Collecting configury of the fpga/ parts
as well as the subdevices scattered over the tree.

The user is not prevented from manually picking the equivlent.

Some documentation started to track the subdevices needed
that are not in the fpga dir as well as guiding the user to
identify the appropriate top level config.


Tom Rix (1):
  fpga: dfl: RFC PCI config

 Documentation/fpga/dfl.rst | 33 +++++++++++++++++++++++++++++++++
 drivers/fpga/Kconfig       | 28 ++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

-- 
2.18.1

