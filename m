Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD201F08D7
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Jun 2020 23:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgFFVCx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 6 Jun 2020 17:02:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27552 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727994AbgFFVCw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Jun 2020 17:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591477371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+D2GdxTX6b6hA1PHo0qrCmyz04ljiq/Wrl6lhJ+DuTY=;
        b=FmvQs2qlTWRI+KURV8JS/qJbECne/0SQiapAZ5PFETOgxwFnGTs12etUVifxkXbK+PIsrI
        fqy0wzzOe9JP+9eaiz3FNsIG9CCzLewJATEknclX+oBIJC5vICiflxQQK1hBp5SBggeIbs
        pzIQkNjIt4s0J+CAboyMX2Ck3K1ko8o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-0VwGttfrPgaPK4Ncq2I5SA-1; Sat, 06 Jun 2020 17:02:49 -0400
X-MC-Unique: 0VwGttfrPgaPK4Ncq2I5SA-1
Received: by mail-qv1-f72.google.com with SMTP id k35so10634385qva.18
        for <linux-fpga@vger.kernel.org>; Sat, 06 Jun 2020 14:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+D2GdxTX6b6hA1PHo0qrCmyz04ljiq/Wrl6lhJ+DuTY=;
        b=IOtOfdgZeuXvQqxVl5N5BZVgEP4tGXkfgFWI2XTkBiz9Ppbwgz8QUDoeTzBkeEvdj4
         a+v6r6K6OyBWQNnS++vKJZJEBe+u/O3vy62HnCgDulI6T3dbpn1a7uDkOlWVojTVa/zb
         F6LuMXImCJENLO+SPllbpub5VlROGb3Nzx5AupuNi2EJHjjE8BUDsBKk9xc6ctFPmbYB
         0Ls9+y+W0AIc5mZ9NaDKxfpFib8Cl4WAP3wLlf8+hsDZQ02yGLchOzAEuwYwZiEJgi7w
         ybSkMmiZ3QONB2qlLvH8f1vDrDkoSMA9cIfyDIhURpO+/l695hYKexPgyLzYxZR5+Guq
         faaw==
X-Gm-Message-State: AOAM5302UfTAxkSM482QKdFe9ElW+XsHh/W6pe7hH2GnIe1SuAKjZ9YY
        htZrseWTmYxHGCRty9CyQdJ0YsxgfNMmPp4jQggik4ZpXk5rLludHaEX+PSXRBH+uCa51EdPNqR
        nlum31VOrmqdrihoBwZC3ew==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr7472246qkm.310.1591477369486;
        Sat, 06 Jun 2020 14:02:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw65D2mGOUIJtzIY7DgEMQIIow8keOsqE+PTJD5okzf/CUeT0JbIh3nJd4smxJsAU+Cg+2Sug==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr7472221qkm.310.1591477369152;
        Sat, 06 Jun 2020 14:02:49 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d14sm3025299qkg.25.2020.06.06.14.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 14:02:48 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 0/1] fpga: dfl: Fix dead store
Date:   Sat,  6 Jun 2020 14:02:40 -0700
Message-Id: <20200606210241.7459-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Repo linux-next
Tag next-20200605

A couple of fixes for dead stores found by clang's sa tool scan-build

Tom Rix (1):
  Fix dead store

 drivers/fpga/fpga-bridge.c | 6 ++----
 drivers/fpga/fpga-mgr.c    | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.26.0

